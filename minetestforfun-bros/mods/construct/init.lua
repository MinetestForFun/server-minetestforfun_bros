
local construct = {}
construct.path = minetest.get_modpath("construct") .. "/parcours/"
construct.parcours = {}
construct.nodes = {}



function construct.load_nodes()
local file, err = io.open(construct.path.."nodes.txt", "r")
	if file then
		local data = file:read()
		file:close()
		if data then
			local t = minetest.deserialize(data)
			if t and type(t) == "table" then
				return t
			else
				minetest.log("error", "wrong data type("..type(t)..") in".. construct.path.."nodes.txt")
			end
		else
			minetest.log("error", "no data in file".. construct.path.."nodes.txt")
		end
	else
		minetest.log("error", "open(" ..construct.path.."nodes.txt, 'w') failed: " .. err)
	end
	return {}
end
construct.nodes = construct.load_nodes()


function construct.load_parcours(name)
	local file, err = io.open(construct.path..name..".txt", "r")
	if file then
		local data = file:read()
		file:close()
		if data then
			local t = minetest.deserialize(data)
			if t and type(t) == "table" then
				return t
			else
				minetest.log("error", "wrong data type("..type(t)..") in".. construct.path..name..".txt")
			end
		else
			minetest.log("error", "no data in file".. construct.path..name..".txt")
		end
	else
		minetest.log("error", "open(" ..construct.path..name..".txt, 'w') failed: " .. err)
	end
	return nil
end

--construct.parcours["p1"] = construct.load_parcours("parcours1")



function construct.get_pos(abspos, dir, rpos)
	local pos2 = {x=abspos.x, y=abspos.y, z=abspos.z}
	if not rpos or not rpos.x or not rpos.y or not rpos.z  then return pos2 end
	pos2.y=pos2.y+rpos.y
	if dir == "N" then
		pos2.x=pos2.x+rpos.x
		pos2.z=pos2.z+rpos.z
	elseif dir == "S" then
		pos2.x=pos2.x-rpos.x
		pos2.z=pos2.z-rpos.z
		
	elseif dir == "E" then
		pos2.x=pos2.x+rpos.z
		pos2.z=pos2.z-rpos.x
	elseif dir == "W" then
		pos2.x=pos2.x-rpos.z
		pos2.z=pos2.z+rpos.x
	end
	return pos2
end


function construct.set_parcours(num, startpos, dir)
	for _, p in pairs(construct.parcours[num]) do
		for _, c in pairs(p) do
			print(dump(c))
			local rpos = {x=c.x,y=c.y,z=c.z}
			local npos = construct.get_pos(startpos, dir, rpos)
			local nname = construct.nodes[c.node]
			if nname ~= "air" then
				minetest.set_node({x=npos.x, y=npos.y, z=npos.z }, {name=nname})
			end
		end
	end
end

		if #construct.parcours == 0 then
			construct.parcours = {}
			local i
			for i=1, 10 do
				construct.parcours[i] = construct.load_parcours("parcours"..i)
				print("parcours"..i)
				if construct.parcours[i] == nil then
					break
				end
			end
end
minetest.register_chatcommand("pload", {
	description = "load parcours from schematic",
	privs = {server=true},
	params = "",
	func = function(name, param)
		if #construct.parcours == 0 then
			construct.parcours = {}
			local i
			for i=1, 10 do
				construct.parcours[i] = construct.load_parcours("parcours"..i)
				print("parcours"..i)
				if construct.parcours[i] == nil then
					break
				end
			end
			if #construct.parcours == 0 then
				return false, "load parcours impossible"
			end
		end
		return true, "files loaded:"..#construct.parcours
	end,
})





minetest.register_chatcommand("pset", {
	description = "construct parcours from schematic",
	privs = {server=true},
	params = "parcours x y z dir",
	func = function(name, param)
		if not param then
			return false, "missing param, /pset name x y z dir"
		end
		local param_num, param_x, param_y, param_z, param_dir = param:match("^(%S+)%s(%S+)%s(%S+)%s(%S+)%s(%S+)$")
		if  param_num == nil or param_x == nil or param_y == nil or param_z == nil or param_dir == nil then
			return false, "invalid param, /pset name x y z dir"
		end
		local num = tonumber(param_num)
		local x = tonumber(param_x)
		local y = tonumber(param_y)
		local z = tonumber(param_z)
		
		if not num then
			return false,"invalid param parcours"
		end
		if not x then
			return false,"invalid param x"
		end		
		if not y then
			return false,"invalid param y"
		end		
		if not z then
			return false,"invalid param z"
		end
		if param_dir ~= "N" and param_dir ~= "S" and param_dir ~= "E" and param_dir ~= "W" then		
			return false,"invalid param dir"
		end
		if construct.parcours[num] == nil then
			return false, "parcours not loaded"
		end
		construct.set_parcours(num, {x=x,y=y,z=z}, param_dir)
		return true, "parcours finished"	
	end,
})





--function make platform damier
minetest.register_chatcommand("setdamier", {
	description = "set damier size x y z dir>.",
	privs = {server=true},
	func = function(name, param)
		if not param then
			return false, "missing param, /setdamier size x y z dir"
		end
		local param_size, param_x, param_y, param_z, param_dir = param:match("^(%S+)%s(%S+)%s(%S+)%s(%S+)%s(%S+)$")
		if  param_size == nil or param_x == nil or param_y == nil or param_z == nil or param_dir == nil then
			return false, "invalid param, /setdamier size x y z dir"
		end
		local size = tonumber(param_size)
		local x = tonumber(param_x)
		local y = tonumber(param_y)
		local z = tonumber(param_z)
		if not size then
			return false,"invalid param size"
		end
		if not x then
			return false,"invalid param x"
		end
		if not y then
			return false,"invalid param y"
		end
		if not z then
			return false,"invalid param z"
		end

		if param_dir ~= "N" and param_dir ~= "S" and param_dir ~= "E" and param_dir ~= "W" then		
			return false,"invalid param dir"
		end
		local dir = param_dir
		
		local abspos = {x=x, y=y, z=z}
		local i = 1
		local j = 1
		local tx,tz
		for tx=0, size do
			for tz=0, size do
				local pos2 = construct.get_pos(abspos, dir, {x=tx,y=y,z=tz})
				if i == 1 then
					minetest.set_node(pos2, {name="default:damier_black"})
					i = 2
				else
					minetest.set_node(pos2, {name="default:damier_white"})
					i = 1
				end
			end
			if j == 1 then
				j = 2
				i = 2
			else
				j = 1
				i = 1
			end			
		end
		print("fini")
	end,
})

