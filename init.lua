mobs:register_mob("stone_elemental:stone_elemental", {
	type = "monster",
	passive = false,
	attack_npcs = false,
	attack_type = "dogshoot",
	shoot_interval = 0.5,
	shoot_offset = 1.5,
	arrow = "stone_elemental:rock",
    knock_back = true,
	pathfinding = true,
	reach = 8,
	damage = 3,
	hp_min = 250,
	hp_max = 290,
	armor = 80,
	visual = "mesh",
	visual_size = {x = 17, y = 17},
	mesh = "stone_elemental.b3d",
	collisionbox = {-1.0/2, -0.8, -1.0/2, 1.0/2, 1.0, 1.0/2},
	rotate = 90,
	textures = {
		{"stone_elemental.png"},
	},
    immune_to = {
		{"default:pick_stone", 0},
		{"default:shovel_stone", 0},
		{"default:axe_stone", 0},
		{"default:sword_stone", 0}
	},
	blood_texture = "default_stone.png",
	fly = true ,
	fly_in = "air",
	walk_velocity = 3,
	run_velocity = 5,
	jump_height = 4,
	stepheight = 1,
	floats = 0,
	view_range = 10,
	drops = {
		{name = "default:stone", chance = 3, min = 15, max = 30},
        {name = "default:diamond", chance = 1, min = 2, max = 5},
        {name = "default:coal_lump", chance = 2, min = 6, max = 16},
        {name = "default:gold_lump", chance = 2, min = 3, max = 6},
        {name = "default:iron_lump", chance = 2, min = 3, max = 12},
	},
	water_damage = 1,
	lava_damage = 0,
	light_damage = 1,
	animation = {
		speed_run = 15,
		stand_start = 1,
		stand_end = 90,
		walk_start = 1,
		walk_end = 90,
		run_start = 1,
		run_end = 90,
		shoot_start = 90,
		shoot_end = 115,
	},
	on_spawn = function () end,
	on_die = function(self, pos) end,

})

mobs:register_arrow("stone_elemental:rock", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"stone_elemental_rock.png"},
    collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.05, 0.1},
	velocity = 16,
	tail = 1,
	tail_texture = "stone_elemental_rock.png",
	tail_size = 10,
	expire = 0.1,
	on_activate = function(self, staticdata, dtime_s)
		self.object:set_armor_groups({immortal = 1, fleshy = 100})
	end,

    on_punch = function(self, hitter, tflp, tool_capabilities, dir)
		if hitter and hitter:is_player() and tool_capabilities and dir then
			local damage = tool_capabilities.damage_groups and
			tool_capabilities.damage_groups.fleshy or 1
			local tmp = tflp / (tool_capabilities.full_punch_interval or 1.4)
			if damage > 6 and tmp < 4 then
				self.object:set_velocity({
					x = dir.x * self.velocity,
					y = dir.y * self.velocity,
					z = dir.z * self.velocity,
				})
			end
		end
	end,
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 0.5,
			damage_groups = {fleshy = 7},
		}, nil)
	end,
	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 7},
		}, nil)
	end,

	on_spawn = function () end,
	hit_node = function(self, pos, node) end,
})

mobs:spawn({
	name = "stone_elemental:stone_elemental",
	nodes = {"air"},
	max_light = 5,
	interval = 60,
    chance = 700,
	max_height = -550,
	min_height = -30000,
})

mobs:register_egg("stone_elemental:stone_elemental", "Stone Element", "default_stone.png", 1)
