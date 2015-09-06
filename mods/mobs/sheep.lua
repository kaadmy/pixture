-- Sheep by PilzAdam; tweaked for Pixture by Kaadmy

mobs:register_mob(
   "mobs:sheep",
   {
      type = "animal",
      passive = true,
      hp_min = 6,
      hp_max = 14,
      armor = 200,
      collisionbox = {-0.4, -1, -0.4, 0.4, 0.1, 0.4},
      visual = "mesh",
      mesh = "mobs_sheep.x",
      visual_size = {x = 1, y = 1},
      textures = {
	 {"mobs_sheep.png"},
      },
      gotten_texture = {"mobs_sheep_shaved.png"},
--      gotten_mesh = "mobs_sheep.x",
      makes_footstep_sound = true,
      sounds = {
	 random = "mobs_sheep",
	 distance = 16,
      },
      walk_velocity = 1,
      walk_chance = 150,
      jump = true,
      jump_height = 5,
      drops = {
	 {name = "mobs:meat_raw",
	  chance = 1, min = 2, max = 4},
	 {name = "mobs:wool",
	  chance = 1, min = 1, max = 2},
      },
      water_damage = 1,
      lava_damage = 5,
      light_damage = 0,
      animation = {
	 speed_normal = 15,
	 speed_run = 25,
	 stand_start = 0,
	 stand_end = 60,
	 walk_start = 61,
	 walk_end = 80,
      },
      follow = "farming:wheat",
      view_range = 5,
      replace_rate = 50,
      replace_what = {"default:grass", "default:tall_grass", "farming:wheat_3", "farming:wheat_4"},
      replace_with = "air",
      replace_offset = -1,
      on_replace = function(self, pos)
		      minetest.set_node(pos, {name = self.replace_with})
		      if mobs:feed_tame(self, self.follow, 8, true) then
			 if self.gotten == false then
			    self.object:set_properties(
			       {
				  textures = {"mobs_sheep.png"},
				  mesh = "mobs_sheep.x",
			       })
			 end
		      end
		   end,
      on_rightclick = function(self, clicker)
			 --are we feeding?
			 if mobs:feed_tame(self, clicker, 8, true) then
			    --if full grow fuzz
			    if self.gotten == false then
			       self.object:set_properties(
				  {
				     textures = {"mobs_sheep.png"},
				     mesh = "mobs_sheep.x",
				  })
			    end
			    return
			 end

			 local item = clicker:get_wielded_item()
			 local itemname = item:get_name()

			 --are we giving a haircut>
			 if itemname == "mobs:shears" then
			    if self.gotten == false and self.child == false then
			       self.gotten = true -- shaved
			       local pos = self.object:getpos()
			       pos.y = pos.y + 0.5
			       local obj = minetest.add_item(pos, ItemStack("mobs:wool"))
			       if obj then
				  obj:setvelocity(
				     {
					x = math.random(-1,1),
					y = 5,
					z = math.random(-1,1)
				     })
			       end
			       item:add_wear(650) -- 100 uses
			       clicker:set_wielded_item(item)
			       self.object:set_properties(
				  {
				     textures = {"mobs_sheep_shaved.png"},
				     mesh = "mobs_sheep.x",
				  })
			    end
			    return
			 end

			 local name = clicker:get_player_name()

			 --are we capturing?
			 mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
		      end
   })

mobs:register_egg("mobs:sheep", "Sheep", "mobs_sheep_inventory.png")
mobs:register_spawn("mobs:sheep", {"default:dirt_with_grass"}, 20, 10, 15000, 1, 31000)