-- Based off MT's core builtin/game/statbars.lua, changed a lot to add statbar background and better layout

default.hud={}

local health_bar_definition = {
   hud_elem_type = "statbar",
   position = { x=0.5, y=1 },
   text = "heart.png",
   number = 20,
   direction = 0,
   size = { x=16, y=16 },
   offset = { x=(-10*16)-64, y=-(48+24+16)},
}

local breath_bar_definition = {
   hud_elem_type = "statbar",
   position = { x=0.5, y=1 },
   text = "bubble.png",
   number = 20,
   dir = 0,
   size = { x=16, y=16 },
   offset = {x=64,y=-(48+24+16)-16},
}

local health_bar_bg = {
   hud_elem_type = "statbar",
   position = { x=0.5, y=1 },
   text = "heart.png^[colorize:#666666:255",
   number = 20,
   direction = 0,
   size = { x=16, y=16 },
   offset = { x=(-10*16)-64, y=-(48+24+16)},
}

local breath_bar_bg = {
   hud_elem_type = "statbar",
   position = { x=0.5, y=1 },
   text = "bubble.png^[colorize:#666666:255",
   number = 20,
   dir = 0,
   size = { x=16, y=16 },
   offset = {x=64,y=-(48+24+16)-16},
}

default.hud.ids={}

function default.hud.initialize_builtin_statbars(player)
   if not player:is_player() then
      return
   end

   local name = player:get_player_name()

   if name == "" then
      return
   end

   player:hud_set_hotbar_selected_image("ui_hotbar_selected.png")
   player:hud_set_hotbar_image("ui_hotbar_bg.png")

   if default.hud.ids[name] == nil then
      default.hud.ids[name] = {}
      -- flags are not transmitted to client on connect, we need to make sure
      -- our current flags are transmitted by sending them actively
      local flg=player:hud_get_flags()
      flg["healthbar"]=false
      flg["breathbar"]=false

      player:hud_set_flags(flg)
   end

   if minetest.is_yes(minetest.setting_get("enable_damage")) then
      if default.hud.ids[name].id_healthbar == nil then
	 health_bar_definition.number = player:get_hp()
	 default.hud.ids[name].id_healthbar_bg  = player:hud_add(health_bar_bg)
	 default.hud.ids[name].id_healthbar  = player:hud_add(health_bar_definition)
      end
   else
      if default.hud.ids[name].id_healthbar ~= nil then
	 player:hud_remove(default.hud.ids[name].id_healthbar)
	 default.hud.ids[name].id_healthbar = nil
      end
   end

   if (player:get_breath() < 11) then
      if minetest.is_yes(minetest.setting_get("enable_damage")) then
	 if default.hud.ids[name].id_breathbar == nil then

	    default.hud.ids[name].id_breathbar_bg  = player:hud_add(breath_bar_bg)
	    default.hud.ids[name].id_breathbar = player:hud_add(breath_bar_definition)
	 end
      else
	 if default.hud.ids[name].id_breathbar ~= nil then
	    player:hud_remove(default.hud.ids[name].id_breathbar)
	    player:hud_remove(default.hud.ids[name].id_breathbar_bg)
	    default.hud.ids[name].id_breathbar = nil
	 end
      end
   elseif default.hud.ids[name].id_breathbar ~= nil then
      player:hud_remove(default.hud.ids[name].id_breathbar)
      player:hud_remove(default.hud.ids[name].id_breathbar_bg)
      default.hud.ids[name].id_breathbar = nil
   end
end

function default.hud.cleanup_builtin_statbars(player)
   if not player:is_player() then
      return
   end

   local name = player:get_player_name()

   if name == "" then
      return
   end

   default.hud.ids[name] = nil
end

function default.hud.player_event_handler(player, eventname)
   assert(player:is_player())

   local name = player:get_player_name()

   if name == "" then
      return
   end

   if eventname == "health_changed" then
      default.hud.initialize_builtin_statbars(player)

      if default.hud.ids[name].id_healthbar ~= nil then
	 player:hud_change(default.hud.ids[name].id_healthbar,"number",player:get_hp())
	 return true
      end
   end

   if eventname == "breath_changed" then
      default.hud.initialize_builtin_statbars(player)

      if default.hud.ids[name].id_breathbar ~= nil then
	 player:hud_change(default.hud.ids[name].id_breathbar,"number",player:get_breath()*2)
	 return true
      end
   end

   if eventname == "hud_changed" then
      default.hud.initialize_builtin_statbars(player)
      return true
   end

   return false
end

function default.hud.replace_builtin(name, definition)
   if definition == nil or type(definition) ~= "table" or definition.hud_elem_type ~= "statbar" then
      return false
   end

   if name == "health" then
      health_bar_definition = definition

      for name,ids in pairs(default.hud.ids) do
	 local player = minetest.get_player_by_name(name)
	 if  player and default.hud.ids[name].id_healthbar then
	    player:hud_remove(default.hud.ids[name].id_healthbar)
	    default.hud.initialize_builtin_statbars(player)
	 end
      end
      return true
   end

   if name == "breath" then
      breath_bar_definition = definition

      for name,ids in pairs(default.hud.ids) do
	 local player = minetest.get_player_by_name(name)
	 if  player and default.hud.ids[name].id_breathbar then
	    player:hud_remove(default.hud.ids[name].id_breathbar)
	    default.hud.initialize_builtin_statbars(player)
	 end
      end
      return true
   end

   return false
end

minetest.register_on_joinplayer(default.hud.initialize_builtin_statbars)
minetest.register_on_leaveplayer(default.hud.cleanup_builtin_statbars)
minetest.register_playerevent(default.hud.player_event_handler)

default.log("hud", "loaded")

