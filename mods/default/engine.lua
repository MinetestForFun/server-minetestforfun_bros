engine = {}
engine.file_tracks = minetest.get_worldpath() .. "/tracks.txt"
engine.players = {} -- registred players
engine.tracks = {} -- registred tracks
engine.ingame_tracks = {} -- ingame tracks



minetest.register_privilege("track_admin", {
	description = "Allows modification of tracks",
	give_to_singleplayer = true,
	default = false
})


function engine.load()
	local file, err = io.open(engine.file_tracks, "r")
	if file then
		local data = minetest.deserialize(file:read("*all"))
		file:close()
		if data and type(data) == "table" then
			engine.tracks = data
		end
	else
		minetest.log("error", "open(" .. engine.file_tracks .. ", 'r') failed: " .. err)
	end
end


function engine.save()
	local input, err = io.open(engine.file_tracks, "w")
	if input then
		input:write(minetest.serialize(engine.tracks))
		input:close()
	else
		minetest.log("action","Open failed (mode:w) of " .. engine.file_tracks .." error:" ..err)
	end
end


function engine.add_track(pos)
	table.insert(engine.tracks, {pos=pos, enable=false})
	engine.save()
	return #engine.tracks
end


function engine.del_track(track)
	engine.tracks[track] = nil
	engine.save()
end


function engine.enable_track(track)
	if engine.tracks[track] then
		engine.tracks[track]["enable"] = true
		engine.ingame_tracks[track] = {ingame=false, pos=engine.tracks.pos}
		engine.save()
		return true
	else
		return false
	end
end


function engine.disable_track(track)
	if engine.tracks[track] then
		engine.tracks[track]["enable"] = false
		engine.ingame_tracks[track] = nil
		engine.save()
		return true
	else
		return false
	end
end


--[[
function engine.get_pos_track(track)
	if engine.tracks[track] then
		return engine.tracks[track].pos
	end
	return nil
end
--]]

function engine.set_enabled_tracks()
	engine.ingame_tracks = {}
	for i, track in ipairs(engine.tracks) do
		if track.enable then
			engine.ingame_tracks[i] = {ingame=false, pos=track.pos}
		end
	end
end


function engine.set_ingame_track(name, track)
	if not engine.players[name] and engine.ingame_tracks[track] and engine.ingame_tracks[track]["ingame"] == false then
		engine.ingame_tracks[track]["ingame"] = true
		engine.players[name] = track
		return true
	end
	return false
end


function engine.unset_ingame_track(name, track)
	if engine.ingame_tracks[track] and engine.ingame_tracks[track]["ingame"] == true then
		engine.ingame_tracks[track]["ingame"] = false
		engine.players[name] = nil
		return true
	end
	return false
end


function engine.get_free_track()
	for i, track in ipairs(engine.ingame_tracks) do
		if track.ingame == false then
			return i
		end
	end
	return nil
end

function engine.get_pos_track(track)
	if engine.ingame_tracks[track] then
		return engine.ingame_tracks[track].pos
	end
	return nil
end


minetest.register_chatcommand("track_enable", {
	params = "track number",
	description = "Disable a track",
	privs = { track_admin = true },
	func = function(name, param)
		local track = tonumber(param)
		if track then
			if engine.enable_track(track) then
				return true, "Track ".. track .. " enabled"
			else
				return false, "Track ".. track .. " do not exist"
			end
		else
			return false, "Param incorrect: \"" .. param .. "\""
		end
	end,
})

minetest.register_chatcommand("track_disable", {
	params = "track number",
	description = "Disable a track",
	privs = { track_admin = true },
	func = function(name, param)
		local track = tonumber(param)
		if track then
			if engine.disable_track(track) then
				return true, "Track ".. track .. " disabled"
			else
				return false, "Track ".. track .. " do not exist"
			end
		else
			return false, "Param incorrect: \"" .. param .. "\""
		end
	end,
})


-- tracking block to regiter track and set position
minetest.register_node("default:track_block", {
	description = "Block To Register Track Start Pos",
	tiles = {"default_track_block.png"},
	inventory_image = "default_track_block.png",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
	drop = {},
	on_construct = function(pos)
		local track = engine.add_track(pos)
		local meta = minetest.get_meta(pos)
		if track then
			meta:set_int("track", track)
			meta:set_string("infotext", "track ".. track)
		end
	end,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local track = meta:get_int("track")
		if track then
			engine.del_track(track)
		end
	end,
})

-- tracking block to start track
minetest.register_node("default:teleport_block", {
	description = "Teleport Block To Free Track",
	tiles = {"default_teleport_block.png"},
	inventory_image = "default_teleport_block.png",
	paramtype2 = "facedir",
	is_ground_content = true,
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
	drop = {},
	on_punch = function(pos, node, puncher, pointed_thing)
		local name = puncher:get_player_name()
		if engine.players[name] then
			minetest.chat_send_player(name, "Sorry, you have already started a track.")
			return
		end
		local track = engine.get_free_track()
		if track then
			local track_pos = engine.get_pos_track(track)
			if track_pos then
				engine.set_ingame_track(name, track)
				puncher:setpos(track_pos)
			end
		else
			minetest.chat_send_player(name, "Sorry, there are no track free.")
		end
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Punch me to start a track")
	end,
})


minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if engine.players[name] then
		engine.unset_ingame_track(name, engine.players[name])
	end
	engine.players[name] = nil
end)


engine.load()
engine.set_enabled_tracks()

