
--
-- Parachute mod
-- By webdesigner97(No license?)
-- Tweaked by Kaadmy, for Pixture
--

function air_physics(v)
   local m = 80    -- Weight of player, kg
   local g = -9.81 -- Earth Acceleration, m/s^2
   local cw = 1.25 -- Drag coefficient
   local rho = 1.2 -- Density of air (on ground, not accurate), kg/m^3
   local A = 25    -- Surface of the parachute, m^2

   return ((m * g + 0.5 * cw * rho * A * v * v) / m)
end

minetest.register_craftitem(
   "parachute:parachute", {
      description = "Parachute",
      inventory_image = "parachute_inventory.png",
      wield_image = "parachute_inventory.png",
      stack_max = 1,
      on_use = function(itemstack, player, pointed_thing)
         local name = player:get_player_name()

         local pos = player:getpos()

         local on = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})

         if default.player_attached[name] then
            return
         end

         if on.name == "air" then
            -- Spawn parachute
            pos.y = pos.y + 3

            local ent = minetest.add_entity(pos, "parachute:entity")

            ent:setvelocity(
               {
                  x = 0,
                  y = math.min(0, player:get_player_velocity().y),
                  z = 0
            })

            player:set_attach(ent, "", {x = 0, y = -8, z = 0}, {x = 0, y = 0, z = 0})

            ent:setyaw(player:get_look_horizontal())

            ent = ent:get_luaentity()
            ent.attached = name

            default.player_attached[player:get_player_name()] = true

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
         local pos = self.object:getpos()
         local under = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})

         if self.attached ~= nil then
            local player = minetest.get_player_by_name(self.attached)

            local vel = self.object:getvelocity()

            local accel = {x = 0, y = 0, z = 0}

            local lookyaw = math.pi - player:get_look_horizontal()

            if lookyaw < 0 then
               lookyaw = lookyaw + (math.pi * 2)
            end

            if lookyaw >= (math.pi * 2) then
               lookyaw = lookyaw - (math.pi * 2)
            end
--            self.object:setyaw(lookyaw)

            local s = math.sin(lookyaw)
            local c = math.cos(lookyaw)

            local sr = math.sin(lookyaw - (math.pi / 2))
            local cr = math.cos(lookyaw - (math.pi / 2))

            local controls = player:get_player_control()

            local speed = 4.0

            if controls.down then
               accel.x = s * speed
               accel.z = c * speed
            elseif controls.up then
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

            accel.y = accel.y + air_physics(vel.y) * 0.25

            self.object:setacceleration(accel)

            if under.name ~= "air" then
               default.player_attached[self.attached] = false
            end
         end

         if under.name ~= "air" then
            if self.attached ~= nil then
               default.player_attached[self.attached] = false

               self.object:set_detach()
            end

            self.object:remove()
         end
      end
})

-- Crafting

crafting.register_craft(
   {
      output = "parachute:parachute",
      items = {
         "group:fuzzy 3",
         "default:rope 4",
         "default:stick 6",
      }
})

-- Achievements

achievements.register_achievement(
   "sky_diver",
   {
      title = "Sky Diver",
      description = "Craft 5 parachutes.",
      times = 5,
      craftitem = "parachute:parachute",
})

default.log("mod:parachute", "loaded")
