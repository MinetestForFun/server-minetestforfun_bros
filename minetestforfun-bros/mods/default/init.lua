-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.


-- The API documentation in here was moved into game_api.txt

-- Definitions made by this mod that other mods can use too
default = {}

default.LIGHT_MAX = 14
default.WATER_ALPHA = 160
default.WATER_VISC = 1
default.LAVA_VISC = 7


-- GUI related stuff
default.gui_bg = "bgcolor[#080808BB;true]"
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots = "listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]"

function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end




hotbar_size = minetest.setting_get("hotbar_size") or 16
-- Update appearance when the player joins
minetest.register_on_joinplayer(function(player)
	player:hud_set_hotbar_itemcount(hotbar_size)
end)

default.gui_survival_form = "size[8,8.5]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;1.75,0.5;3,3;]"..
			"list[current_player;craftpreview;5.75,1.5;1,1;]"..
			"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)

-- Load files
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/engine.lua")
dofile(minetest.get_modpath("default").."/player.lua")

-- Code below by Casimir.

local function count_items()
	local i = 0
	local number = 0
	for name, item in pairs(minetest.registered_items) do
		if (name and name ~= "") then
			number = number + 1
		end
		i = i + 1
	end
	minetest.log("action", "There are " .. number .. " registered nodes, items and tools.")
end
minetest.after(1, count_items)

hotbar_size = minetest.setting_get("hotbar_size") or 16

minetest.register_on_joinplayer(function(player)
	player:set_physics_override({
    sneak_glitch = false, -- Climable blocks are quite fast in Carbone.
  })
	player:hud_set_hotbar_itemcount(hotbar_size)
end)




minetest.log("action", "") -- Empty line.
minetest.log("action", "") -- Empty line.

if minetest.setting_getbool("creative_mode") then
	minetest.log("action", "Creative mode is enabled.")
else
	minetest.log("action", "Creative mode is disabled.")
end

if minetest.setting_getbool("enable_damage") then
	minetest.log("action", "Damage is enabled.")
else
	minetest.log("action", "Damage is disabled.")
end

if minetest.setting_getbool("enable_pvp") then
	minetest.log("action", "PvP is enabled.")
else
	minetest.log("action", "PvP is disabled.")
end

if not minetest.is_singleplayer() and minetest.setting_getbool("server_announce") then
	minetest.log("action", "") -- Empty line.
	minetest.log("action", "Server name: " .. minetest.setting_get("server_name") or "(none)")
	minetest.log("action", "Server description: " .. minetest.setting_get("server_description") or "(none)")
	minetest.log("action", "Server URL: " .. minetest.setting_get("server_address") or "(none)")
	minetest.log("action", "MOTD: " .. minetest.setting_get("motd") or "(none)")
	minetest.log("action", "Maximum users: " .. minetest.setting_get("max_users") or 15)
end

minetest.log("action", "") -- Empty line.
minetest.log("action", "") -- Empty line.

