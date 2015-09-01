
-- Turtle.lua by farfadet46 from 'mobs_cow' by Krupnovpavel

mobs:register_mob("turtle:turtle", {
	-- animal, monster, npc, barbarian
	type = "animal",
	-- aggressive, does 5 damage to player when threatened
	passive = false,
	group_attack = true,
	attack_type = "dogfight",
	damage = 4,
	-- health & armor
	hp_min = 25,
	hp_max = 30,
	armor = 200,
	-- textures and model
	collisionbox = {-0.4, 0, -0.4, 0.4, 1.2, 0.4},
	visual = "mesh",
	mesh = "turtle_turtle.b3d",
	visual_size = {x = 3, y = 3, z = 3},
	textures = {
		{"turtle_turtle.png"},
	},
	blood_texture = "mobs_blood.png",
	-- sounds
	makes_footstep_sound = true,
	sounds = {
		random = "turtle_turtlesound",
	},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	jump = false,
	-- drops raw meat when dead
	drops = {
		{name = "default:gold_lump",
		chance = 1, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	-- model animation
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 30,
		walk_start = 35,		walk_end = 65,
		run_start = 105,		run_end = 135,
		punch_start = 70,		punch_end = 100, -- est en mode couché :)
	},

	-- mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
})


-- spawn on default;green;prairie grass between 0 and 20 light, 1 in 11000 chance, 1 cow in area up to 31000 in height
-- mobs:spawn_specific("mobs:cow", {"default:dirt_with_grass"}, {"air"}, 8, 20, 30, 10000, 1, -31000, 31000, true)
-- register spawn egg
mobs:register_egg("turtle:turtle", "Turtle", "default_grass.png", 1)
