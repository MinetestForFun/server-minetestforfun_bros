local path = minetest.get_modpath("mobs")

-- Mob Api
dofile(path.."/api.lua")

-- Animals
dofile(path.."/turtle.lua")


if minetest.setting_get("log_mods") then
	minetest.log("action", "mobs loaded")
end
