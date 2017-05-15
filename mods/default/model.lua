
-- Copied from minetest_game and changed a bit

-- Minetest 0.4 mod: player
-- See README.txt for licensing and other information.

-- Variable for animation speed; 30-35 is good

local player_animation_speed = 33

-- Player animation blending
-- Note: This is currently broken due to a bug in Irrlicht, leave at 0

local animation_blend = 0

default.registered_player_models = {}

-- Local for speed.

local models = default.registered_player_models

function default.player_register_model(name, def)
   models[name] = def
end

-- Default player appearance

default.player_register_model(
   "character.b3d",
   {
      animation_speed = player_animation_speed,
      textures = {"character.png"},
      animations = {
	 -- Standard animations.
	 stand     = {x = 0,   y = 79},
	 lay       = {x = 162, y = 166},
	 walk      = {x = 168, y = 187},
	 mine      = {x = 189, y = 198},
	 walk_mine = {x = 200, y = 219},
	 -- Extra animations (not currently used by the game).
	 sit      = { x = 81, y = 160},
      },
})

-- Player stats and animations

local player_model = {}
local player_textures = {}
local player_anim = {}
local player_sneak = {}

default.player_attached = {}

function default.player_get_animation(player)
   local name = player:get_player_name()

   return {
      model = player_model[name],
      textures = player_textures[name],
      animation = player_anim[name],
   }
end

-- Called when a player's appearance needs to be updated

function default.player_set_model(player, model_name)
   local name = player:get_player_name()
   local model = models[model_name]

   if player_model[name] == model_name then
      return
   end

   player:set_properties(
      {
	 mesh = model_name,
	 textures = player_textures[name] or model.textures,
	 visual = "mesh",
	 visual_size = model.visual_size or {x = 1, y = 1},
   })

   default.player_set_animation(player, "stand")

   player_model[name] = model_name
end

function default.player_get_textures(player)
   if player.get_properties ~= nil then
      return player:get_properties().textures
   else
      return player_textures[player:get_player_name()]
   end
end

function default.player_set_textures(player, textures)
   local name = player:get_player_name()

   player_textures[name] = textures

   player:set_properties({textures = textures})
end

function default.player_set_animation(player, anim_name, speed)
   local name = player:get_player_name()

   if player_anim[name] == anim_name then
      return
   end

   local model = player_model[name] and models[player_model[name]]

   if not (model and model.animations[anim_name]) then
      return
   end

   local anim = model.animations[anim_name]

   player_anim[name] = anim_name

   player:set_animation(anim, speed or model.animation_speed, animation_blend)
end

-- Localize for better performance.

local player_set_animation = default.player_set_animation
local player_attached = default.player_attached

-- Update appearance when the player joins

local function on_joinplayer(player)
   default.player_attached[player:get_player_name()] = false
   default.player_set_model(player, "character.b3d")

   player:set_local_animation(
      {x = 0, y = 79},
      {x = 168, y = 187},
      {x = 189, y = 198},
      {x = 200, y = 219},
      default.player_animation_speed)
end

local function on_leaveplayer(player)
   local name = player:get_player_name()

   player_model[name] = nil
   player_anim[name] = nil
   player_textures[name] = nil
end

local function on_globalstep(dtime)
   for _, player in pairs(minetest.get_connected_players()) do
      local name = player:get_player_name()

      local model_name = player_model[name]
      local model = model_name and models[model_name]

      local controls = player:get_player_control()

      if player_sneak[name] ~= controls.sneak then
         if controls.sneak then
            player:set_nametag_attributes(
               {
                  color = {a = 30, r = 255, g = 255, b = 255}
            })
         else
            player:set_nametag_attributes(
               {
                  color = {a = 255, r = 255, g = 255, b = 255}
            })
         end
      end

      if player_sneak[name] ~= controls.sneak then
         player_sneak[name] = controls.sneak
      end

      if model and not player_attached[name] then
         local walking = false
         local animation_speed_mod = model.animation_speed or player_animation_speed

         -- Determine if the player is walking

         if controls.up or controls.down or controls.left or controls.right then
            walking = true
         end

         -- Determine if the player is sneaking, and reduce animation speed if so

         if controls.sneak then
            animation_speed_mod = animation_speed_mod * 0.6
         end

         -- Apply animations based on what the player is doing

         if player:get_hp() == 0 then -- dead
            player_set_animation(player, "lay")
         elseif walking then -- walking
            if controls.LMB then -- Walking and mining
               player_set_animation(player, "walk_mine", animation_speed_mod)
            else -- Walking
               player_set_animation(player, "walk", animation_speed_mod)
            end
         elseif controls.LMB then -- Mining
            player_set_animation(player, "mine", animation_speed_mod)
         else -- Standing
            player_set_animation(player, "stand", animation_speed_mod)
         end
      end
   end
end

minetest.register_on_joinplayer(on_joinplayer)
minetest.register_on_leaveplayer(on_leaveplayer)

minetest.register_globalstep(on_globalstep)
