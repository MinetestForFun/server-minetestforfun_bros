WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 14


-- Definitions made by this mod that other mods can use too
if not default  then
	default = {}
end


default.inventory_background = "background[0,0;9,8;default_inventory_background.png;true]"
default.inventory_listcolors = "listcolors[#8E6C3C;#EEAF6B;#683E12;#CA7700;#FFFFFF]"

hotbar_size = minetest.setting_get("hotbar_size") or 16
-- Update appearance when the player joins
minetest.register_on_joinplayer(function(player)
	player:hud_set_hotbar_itemcount(hotbar_size)
end)


-- Load files
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/engine.lua")
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

