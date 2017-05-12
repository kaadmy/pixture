
--
-- Wielditem mod
-- By Kaadmy, for Pixture
--

wielditem = {}

local update_time = 1
local timer = 10 -- needs to be more than update_time

minetest.register_craftitem(
   "wielditem:null",
   {
      wield_image = "ui_null.png"
   })

minetest.register_entity(
   "wielditem:wielditem",
   {
      textures = {"default:broadsword"},

      visual = "wielditem",
      visual_size = {x = 0.17, y = 0.17},

      collisionbox = {0, 0, 0, 0, 0, 0},
      hp_max = 1,

      physical = false,
      collide_with_objects = false,
      makes_footstep_sounds = false,

      on_step = function(self, dtime)
		   local player = self.wielder

		   if player == nil or (minetest.get_player_by_name(player:get_player_name()) == nil) then
		      self.object:remove()
		      return
		   end
		   
		   local itemname = player:get_wielded_item():get_name()

		   if itemname ~= "" then
		      self.object:set_properties({textures = {itemname}})
		   else
		      self.object:set_properties({textures = {"wielditem:null"}})
		   end
		end
   })

local function attach_wielditem(player)
   local name = player:get_player_name()
   local pos = player:getpos()

   wielditem[name] = minetest.add_entity(pos, "wielditem:wielditem")
   wielditem[name]:set_attach(player, "right_arm", {x = -1.5, y = 5.7, z = 2.5}, {x = 90, y = -45, z = 270})
   wielditem[name]:get_luaentity().wielder = player
end

local function detach_wielditem(player)
   local name = player:get_player_name()

   wielditem[name]:remove()
   wielditem[name] = nil
end

minetest.register_on_joinplayer(attach_wielditem)
minetest.register_on_leaveplayer(detach_wielditem)

default.log("mod:wielditem", "loaded")