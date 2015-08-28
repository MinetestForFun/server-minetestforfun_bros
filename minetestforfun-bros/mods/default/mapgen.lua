------------------------
-- Mapgeneration Stuff
--

minetest.set_mapgen_params({mgname = "singlenode"})

minetest.register_on_generated(function(minp, maxp, seed)
	-- Set up voxel manip
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local a = VoxelArea:new{
			MinEdge={x=emin.x, y=emin.y, z=emin.z},
			MaxEdge={x=emax.x, y=emax.y, z=emax.z},
	}
	local data = vm:get_data()
	for z = minp.z, maxp.z do
		for x = minp.x, maxp.x do
			for y = minp.y, maxp.y do
				if y == tonumber(minetest.setting_get("bottom_layout")) then
					local vi = a:index(x,y,z)
					data[vi] = minetest.get_content_id("default:block_die")
				end
				if y == 0 and x == 0 and z == 0 then
					local vi = a:index(x,y,z)
					data[vi] = minetest.get_content_id("default:stone")
				end
			end
		end
	end
	vm:calc_lighting()
	vm:update_liquids()
	vm:set_data(data)
	vm:write_to_map(data)
end)

-- Aliases to make the engine happy
minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "air")
