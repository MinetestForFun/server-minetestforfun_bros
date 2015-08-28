-- mods/default/nodes.lua


--stone
minetest.register_node("default:stone", {
	description = "Stone",
	tiles = {"default_stone.png"},
	is_ground_content = true,
	groups = {unbreakable=1},
	drop = '',
	sounds = default.node_sound_stone_defaults(),
})



--brick
minetest.register_node("default:brick", {
	description = "Brick Block Unbreakable",
	tiles = {"default_brick.png"},
	is_ground_content = false,
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

--breakable block
minetest.register_node("default:brick2", {
	description = "Brick Block 2",
	tiles = {"default_brick2.png"},
	is_ground_content = false,
	drop = "default:piece",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		local nb = meta:get_int("piece_nb")
		minetest.sound_play("block_break", {pos = pos, gain = 0.3, max_hear_distance = 6})--FIXME add a "block_break.ogg" sound
		-- FIXME add particules
		
		
		minetest.set_node(pos, {name="air"})
	end,
})

minetest.register_node("default:brick_or", {
	description = "Brick Block 2",
	tiles = {"default_brick_or.png"},
	is_ground_content = false,
	drop = "default:piece",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:brick2_or", {
	description = "Brick Block 2 Unbreakable",
	tiles = {"default_brick_or.png"},
	is_ground_content = false,
	drop = "",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:random_drop", {
	description = "Random Drop Pieces (Unbreakable)",
	tiles = {"default_brick_or.png"},
	is_ground_content = false,
	drop = "",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	light_source = 13,
	inventory_image = minetest.inventorycube("default_surprise_node.png"),
	tiles = {
		"default_surprise_node_top.png", "default_surprise_node_top.png", {name = "default_surprise_node_animated.png", animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5}}
	},
	special_tiles = {
		{
			image = "default_surprise_node_top.png",
			backface_culling=false,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		},
		{
			image = "default_surprise_node_top.png",
			backface_culling=true,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		}
	},
	on_punch = function(pos, node, puncher, pointed_thing)
		local meta = minetest.get_meta(pos)
		local nb = meta:get_int("piece_nb")
		minetest.sound_play("drop_piece", {pos = pos, gain = 0.3, max_hear_distance = 6})--FIXME add a "drop_piece.ogg" sound
		-- FIXME add piece entity or particules
		
		
		if nb and nb > 1 then
			meta:set_int("piece_nb", nb-1)
		else
			minetest.set_node(pos, {name= "default:brick2"})
		end

	end,
	on_construct = function(pos)
		local rand = math.random(1, 10)
		local nb
		if rand == 1 then
			nb = 10
		elseif rand <=3  then
			nb = 5
		else
			nb = 1
		end
		local meta = minetest.get_meta(pos)
		meta:set_int("piece_nb", nb)
	end,
})





minetest.register_node("default:damier_black", {
	description = "Black Damier Block",
	tiles = {"default_damier_black.png"},
	is_ground_content = false,
	drop = "",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:damier_white", {
	description = "White Damier Block",
	tiles = {"default_damier_white.png"},
	is_ground_content = false,
	drop = "",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:sol1", {
	description = "Sol Block 1",
	tiles = {"default_sol1.png"},
	is_ground_content = false,
	drop = "",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:sol2", {
	description = "Sol Block 2",
	tiles = {"default_sol2.png"},
	is_ground_content = false,
	drop = "",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})


for _, i in pairs({"blue", "green", "orange"}) do	
	minetest.register_node("default:steel_"..i.."_top_left", {
		description = i .. " panel block "..i.." (top_left/right)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_top.png", "default_steel_"..i.."_top.png",
		"default_steel_"..i.."_top_right.png", "default_steel_"..i.."_top_left.png"
		
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node("default:steel_"..i.."_top", {
		description = i .. " panel block "..i.." (top)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_top.png", "default_steel_"..i.."_top.png",
		"default_steel_"..i.."_top.png", "default_steel_"..i.."_top.png"
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node("default:steel_"..i.."_left", {
		description = i .. " panel block "..i.." (left/right)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_right.png", "default_steel_"..i.."_left.png"
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node("default:steel_"..i.."_center", {
		description = i .. " panel block "..i.." (center)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png"
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = "",
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})
end


minetest.register_node("default:cloud", {
	description = "Cloud",
	tiles = {"default_cloud.png"},
	sounds = default.node_sound_defaults(),
	groups = {not_in_creative_inventory=1},
})



minetest.register_node("default:water_flowing", {
	description = "Flowing Water",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image="default_water_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="default_water_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:snow",
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1, freezes=1, melt_around=1},
})

minetest.register_node("default:water_source", {
	description = "Water Source",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_water_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="default_water_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:ice",
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, freezes=1},
})

--lava
minetest.register_node("default:lava_source", {
	description = "Lava Source",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_lava_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	special_tiles = {
		-- New-style lava source material (mostly unused)
		{
			name="default_lava_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0},
			backface_culling = false,
		}
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

-- invisible glass , player die when touch 
minetest.register_node("default:block_die",{
	description = "Invisible Die Block",
	drawtype = "glasslike_framed_optional",
	tiles = {"invisible.png"},
	inventory_image = minetest.inventorycube("default_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	diggable = false,
	groups = {unbreakable=1},
	damage_per_second = 20,
})




