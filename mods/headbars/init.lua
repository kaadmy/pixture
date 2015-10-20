--
-- Headbars mod
-- By Kaadmy, for Pixture
--

headbars = {}

local enable_headbars = minetest.setting_getbool("headbars_enable")
if enable_headbars == nil then enable_headbars = true end

local headbars_scale = tonumber(minetest.setting_get("headbars_scale")) or 1

function headbars.get_sprite(icon, background, max, amt)
   local img = "[combine:" .. (max * 8) .. "x16:0,0=ui_null.png:0,0=ui_null.png"
   
   if amt < max then
      for i = 0, max / 2 do
	 img = img .. "^[combine:16x16:0,0=ui_null.png:" .. (i * 16) .. ",0=" .. background
      end
   end

   img = img .. "^([combine:" .. (max * 8) .. "x16:0,0=ui_null.png:0,0=ui_null.png"

   for i = 0, max / 2 do
      if i < (amt - 1) / 2 then
	 img = img .. "^[combine:" .. (max * 8) .. "x16:0,0=ui_null.png:" .. (i * 16) .. ",0=" .. icon
      elseif i < amt / 2 then
	 img = img .. "^[combine:" .. (max * 8) .. "x16:0,0=ui_null.png:" .. (i * 16) .. ",0=" .. icon
	 img = img .. "^[combine:" .. (max * 8) .. "x16:0,0=ui_null.png:" .. (i * 16) .. ",0=headbars_half.png"
      end
   end

   img = img .. "^[makealpha:255,0,255)"

   return img
end

minetest.register_entity(
   "headbars:hpbar",
   {
      visual = "sprite",
      visual_size = {x = 1 * headbars_scale, y = 0.1 * headbars_scale, z = 1},
      textures = {headbars.get_sprite("heart.png", "ui_null.png", 20, 20)},

      physical = false,
      collisionbox = {0, 0, 0, 0, 0, 0},

      on_step = function(self, dtime)
		   local ent = self.wielder

		   if ent == nil or (minetest.get_player_by_name(ent:get_player_name(0)) == nil) then
		      self.object:remove()
		      return
		   end

		   local hp = ent:get_hp()

		   if ent:is_player() then
		      self.object:set_properties({textures = {headbars.get_sprite("heart.png", "headbars_heart_bg.png", 20, hp)}})
		   else
		      self.object:set_properties({textures = {headbars.get_sprite("heart.png", "headbars_heart_bg.png", 20, hp)}})
		   end
		end,
   })

function headbars.attach_hpbar(to)
   if not enable_headbars then return end

   local pos = to:getpos()
   local bar = minetest.add_entity(pos, "headbars:hpbar")

   if bar == nil then return end

   local attach_pos = {x = 0, y = 0, z = 0}
   attach_pos = {x = 0, y = 9, z = 0}

   bar:set_attach(to, "", attach_pos, {x = 0, y = 0, z = 0})
   bar = bar:get_luaentity()
   bar.wielder = to
end

minetest.register_on_joinplayer(headbars.attach_hpbar)
default.log("mod:headbars", "loaded")