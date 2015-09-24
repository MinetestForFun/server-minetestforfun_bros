-- mods/default/nodes.lua
--[[
  Index
  1.
	default:brick
	default:cobble
	default:tiles

  2.
	default:stripes
	default:stripes_surface

  3.
	default:dirt_with_grass

]]--

-- 1. Brick, cobble, tiles
minetest.register_node("default:brick", {
	description = "Bricks",
	tiles = {"default_brick.png"},
	groups = {unbreakable = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:cobble", {
	description = "Cobblestone",
	tiles = {"default_cobble.png"},
	groups = {unbreakable = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tiles", {
	description = "Tiles",
	tiles = {"default_tiles.png"},
	groups = {unbreakable = 1},
	sounds = default.node_sound_defaults(),
})

-- 2. Stipes, stipes block with surface
minetest.register_node("default:stripes", {
	description = "Stripes",
	tiles = {"default_stripes.png"},
	groups = {unbreakable = 1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:stripes", {
	description = "Stripes Surface",
	tiles = {"default_stripe_top.png", "default_stripes.png",
		"default_stripes.png^default_surface_layer.png"}
	groups = {unbreakable = 1},
	sounds = default.node_sound_defaults(),
})

-- 3. Dirt with Grass
minetest.register_node("default:dirt_with_grass",
	description = "Dirt with Grass",
        tiles = {"default_grass.png", "default_dirt.png",
                {name = "default_dirt.png^default_grass_side.png",
                        tileable_vertical = false}},
        groups = {crumbly = 3, soil = 1},
        drop = 'default:dirt',
        sounds = default.node_sound_dirt_defaults({
                footstep = {name = "default_grass_footstep", gain = 0.25},
        }),
})

	


-- Unordered nodes
--stone
minetest.register_node("default:stone", {
	description = "Stone",
	tiles = {"default_stone.png"},
	is_ground_content = true,
	groups = {unbreakable=1},
	drop = {},
	sounds = default.node_sound_stone_defaults(),
})



--brick
minetest.register_node("default:brick_grey", {
	description = "Brick Block Grey Unbreakable",
	tiles = {"default_brick_grey.png"},
	is_ground_content = false,
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:brick_red", {
	description = "Brick Block Red Unbreakable",
	tiles = {"default_brick_red.png"},
	is_ground_content = false,
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:brick_sand", {
	description = "Brick Block Sand Unbreakable",
	tiles = {"default_brick_sand.png"},
	is_ground_content = false,
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

--Tiles
minetest.register_node("default:tiles_orange", {
	description = "Brick Block Tiles Orange",
	tiles = {"default_tiles_orange.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})


--breakable block
minetest.register_node("default:breakable_brick_orange", {
	description = "Brick Block Orange",
	tiles = {"default_breakable_brick_orange.png"},
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

minetest.register_node("default:breakable_brick_white", {
	description = "Brick Block White",
	tiles = {"default_breakable_brick_white.png"},
	is_ground_content = false,
	drop = "default:piece",
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:unbreakable_brick_or", {
	description = "Brick Block Or Unbreakable",
	tiles = {"default_unbreakable_brick_or.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:random_drop", {
	description = "Random Drop Pieces (Unbreakable)",
	tiles = {"default_unbreakable_brick_or.png"},
	is_ground_content = false,
	drop = {},
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
			minetest.set_node(pos, {name= "default:unbreakable_brick_or"})
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

-- Quarter
minetest.register_node("default:quarter_cyan", {
	description = "Quarter Cyan",
	tiles = {"default_quarter_cyan.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:quarter_green", {
	description = "Quarter Green",
	tiles = {"default_quarter_green.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:quarter_red", {
	description = "Quarter Red",
	tiles = {"default_quarter_red.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:quarter_white", {
	description = "Quarter White",
	tiles = {"default_quarter_white.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})


--Sand
minetest.register_node("default:sand", {
	description = "Sand Unbreakable",
	tiles = {"default_sand.png"},
	is_ground_content = false,
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_node("default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png", "default_dirt.png",
		{name = "default_dirt.png^default_grass_side.png",
			tileable_vertical = false}},
	groups = {unbreakable=1},
	drop = {},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.8},
	}),
})

minetest.register_node("default:damier_black", {
	description = "Black Damier Block",
	tiles = {"default_damier_black.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:damier_white", {
	description = "White Damier Block",
	tiles = {"default_damier_white.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

--Stripes
minetest.register_node("default:stripes", {
	description = "Stripes",
	tiles = {"default_stripes.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stripes_surface", {
	description = "Stripes Surface",
	tiles = {"default_stripes_surface.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

--tiled_brick
minetest.register_node("default:tiled_brick_blue", {
	description = "Tiled Brick Blue",
	tiles = {"default_tiled_brick_blue.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tiled_brick_cyan", {
	description = "Tiled Brick Cyan",
	tiles = {"default_tiled_brick_cyan.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tiled_brick_grey", {
	description = "Tiled Brick Grey",
	tiles = {"default_tiled_brick_grey.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tiled_brick_light_blue", {
	description = "Tiled Brick Light Blue",
	tiles = {"default_tiled_brick_light_blue.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tiled_brick_monochrome", {
	description = "Tiled Brick Monochrome",
	tiles = {"default_tiled_brick_monochrome.png"},
	is_ground_content = false,
	drop = {},
	groups = {unbreakable=1},
	sounds = default.node_sound_stone_defaults(),
})



local i
for _, i in pairs({"blue", "green", "orange"}) do
	minetest.register_node("default:steel_"..i.."_top_left", {
		description = i .. " Panel Block (top_left/right)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_top.png", "default_steel_"..i.."_top.png",
		"default_steel_"..i.."_top_right.png", "default_steel_"..i.."_top_left.png",
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = {},
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node("default:steel_"..i.."_top", {
		description = i .. " Panel Block (top)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_top.png", "default_steel_"..i.."_top.png",
		"default_steel_"..i.."_top.png", "default_steel_"..i.."_top.png",
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = {},
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node("default:steel_"..i.."_left", {
		description = i .. " Panel Block (left/right)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_right.png", "default_steel_"..i.."_left.png",
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = {},
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_node("default:steel_"..i.."_center", {
		description = i .. " Panel Block (center)",
		tiles = {
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		"default_steel_"..i.."_center.png", "default_steel_"..i.."_center.png",
		},
		paramtype2 = "facedir",
		is_ground_content = false,
		drop = {},
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
	alpha = default.WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = {},
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = default.WATER_VISC,
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
	alpha = default.WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = {},
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = default.WATER_VISC,
	freezemelt = "default:ice",
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, freezes=1},
})

minetest.register_node("default:water_source_static", {
	description = "Static Water Source",
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
	alpha = default.WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "source",
	liquid_viscosity = default.WATER_VISC,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {static = 1, liquid=3, puts_out_fire=1, freezes=1},
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
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = {},
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = default.LAVA_VISC,
	liquid_renewable = false,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

minetest.register_node("default:lava_source_static", {
	description = "Static Lava Source",
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
	light_source = default.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = default.LAVA_VISC,
	liquid_renewable = false,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava = 3, static = 1, liquid=2, hot = 2, igniter = 1},
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




