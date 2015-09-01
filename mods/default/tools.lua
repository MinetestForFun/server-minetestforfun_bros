minetest.register_tool("default:pick_admin", {
	description = "Admin Pickaxe",
	range = 12,
	inventory_image = "default_adminpick.png",
	--groups = {not_in_creative_inventory = default.creative},
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level = 3,
		groupcaps= {
			unbreakable =	{times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			fleshy =	{times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			choppy =	{times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			bendy =		{times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			cracky =	{times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			crumbly =	{times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			snappy =	{times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
		},
		damage_groups = {fleshy = 1000},
	},
})

minetest.register_tool("default:pick_admin_with_drops", {
	description = "Admin Pickaxe with Drops",
	range = 12,
	inventory_image = "default_adminpick_with_drops.png",
	--groups = {not_in_creative_inventory = default.creative},
	tool_capabilities = {
		full_punch_interval = 0.35,
		max_drop_level = 3,
		groupcaps = {
			unbreakable = {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			fleshy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			choppy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			bendy =       {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			cracky =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			crumbly =     {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			snappy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
		},
		damage_groups = {fleshy = 1000},
	},
})

minetest.register_on_punchnode(function(pos, node, puncher)
	if puncher:get_wielded_item():get_name() == "default:pick_admin"
	and minetest.get_node(pos).name ~= "air" then
		minetest.log("action", puncher:get_player_name() .. " digs " .. minetest.get_node(pos).name .. " at " .. minetest.pos_to_string(pos) .. " using an Admin Pickaxe.")
		minetest.remove_node(pos) -- The node is removed directly, which means it even works on non-empty containers and group-less nodes.
		nodeupdate(pos) -- Run node update actions like falling nodes.
	end
end)



local build_air_place = function(itemstack, player, pointed_thing)
	local inv = player:get_inventory()
	local nname = inv:get_stack("main", player:get_wield_index()+1):get_name()
	if not nname or nname == "" then
		nname = "air"
	end
	local def = minetest.registered_items[nname]
	if not def or  def.type ~= "node" then return end
	local ppos = player:getpos()
	local pyaw = player:get_look_yaw()
	if pyaw < 0 then
		pyaw = 6 + pyaw
	end
	pyaw = (pyaw + 6/8)%6
	pyaw = math.floor(math.floor(pyaw/(6/8))/2)
	local directions = {
		[0] = {x = ppos.x + 1, y = math.floor(ppos.y), z = ppos.z},
		[1] = {x = ppos.x, y = math.floor(ppos.y), z = ppos.z + 1},
		[2] = {x = ppos.x - 1, y = math.floor(ppos.y), z = ppos.z},
		[3] = {x = ppos.x, y = math.floor(ppos.y), z = ppos.z - 1},
	}
	minetest.set_node(directions[pyaw], {name = nname})
	minetest.sound_play("default_place_node", {pos=ppos})
	if not minetest.setting_getbool("creative_mode") then
		inv:remove_item("main", nname)
	end
end


--tools to build on air
minetest.register_tool("default:build_air", {
	description = "Build Air Tool",
	inventory_image = "default_build_air.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		build_air_place(itemstack, user, pointed_thing)
	end,
})

