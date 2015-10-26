--
-- Parachute mod
-- By webdesigner97(No license?)
-- Tweaked by Kaadmy, for Pixture
--

function a(v)
   local m = 80    -- Weight of player, kg
   local g = -9.81 -- Earth Acceleration, m/s^2
   local cw = 1.33 -- Drag coefficient
   local rho = 1.2 -- Density of air (on ground, not accurate), kg/m^3
   local A = 25    -- Surface of the parachute, m^2

   return ((m * g + 0.5 * cw * rho * A * v * v) / m)
end

minetest.register_craftitem(
   "parachute:parachute", {
      inventory_image = "parachute_inventory.png",
      wield_image = "parachute_inventory.png",
      on_use = function(itemstack, player, pointed_thing)
		  local pos = player:getpos()

		  local on = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})

		  if on.name == "air" then
		     -- Spawn parachute
		     pos.y = pos.y + 3

		     local ent = minetest.add_entity(pos, "parachute:entity")

		     ent:setvelocity({x = 0, y = player:get_player_velocity().y, z = 0})

		     player:set_attach(ent, "", {x = 0, y = -8, z = 0}, {x = 0, y = 0, z = 0})

		     ent:setyaw(player:get_look_yaw() - (math.pi / 2))
		     ent = ent:get_luaentity()
		     ent.attached = player

		     itemstack:take_item()
		     return itemstack
		  else
		     minetest.chat_send_player(
			player:get_player_name(),
			"Cannot open parachute on ground!")
		  end
	       end
   })

minetest.register_entity(
   "parachute:entity",
   {
      visual = "mesh",
      mesh = "parachute.b3d",
      textures = {"parachute_mesh.png"},
      collisionbox = {0, 0, 0, 0, 0, 0},
      automatic_face_movement_dir = -90,
      attached = nil,
      on_step = function(self, dtime)
		   if self.attached ~= nil then
		      local vel = self.object:getvelocity()

		      local accel = {x = 0, y = 0, z = 0}

		      local lookyaw = self.attached:get_look_yaw()

		      local s = math.sin((math.pi * 0.5) - lookyaw)
		      local c = math.cos((math.pi * 0.5) - lookyaw)

		      local sr = math.sin(((math.pi * 0.5) - lookyaw) + (math.pi / 2))
		      local cr = math.cos(((math.pi * 0.5) - lookyaw) + (math.pi / 2))

		      local controls = self.attached:get_player_control()

		      local speed = 3.0

		      if controls.up then
			 accel.x = s * speed
			 accel.z = c * speed
		      elseif controls.down then
			 accel.x = s * -speed
			 accel.z = c * -speed
		      end

		      if controls.right then
			 accel.x = sr * speed
			 accel.z = cr * speed
		      elseif controls.left then
			 accel.x = sr * -speed
			 accel.z = cr * -speed
		      end

		      accel.y = accel.y + a(vel.y) * 0.25

		      self.object:setacceleration(accel)
		   end

		   local pos = self.object:getpos()
		   local under = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
		   if under.name ~= "air" then
		      self.object:set_detach()
		      self.object:remove()
		   end
		end
   })

minetest.register_craft(
   {
      output = "parachute:parachute",
      recipe = {
	 {"group:fuzzy", "group:fuzzy", "group:fuzzy"},
	 {"default:rope", "", "default:rope"},
	 {"", "default:stick", ""}
      }
   })

default.log("mod:parachute", "loaded")