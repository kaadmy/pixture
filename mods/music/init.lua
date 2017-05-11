--
-- Music player mod
-- By Kaadmy, for Pixture
--

music = {}

music.default_track = core.setting_get("music_track") or "music_catsong"
music.track_length = tonumber(core.setting_get("music_track_length")) or 30.0
music.volume = tonumber(core.setting_get("music_volume")) or 1.0

music.players = {} -- music players

if core.setting_getbool("music_enable") then
   function music.stop(pos)
      local dp = core.hash_node_position(pos)

      local meta = core.get_meta(pos)
      meta:set_string("infotext", "Music player (Off)")
      meta:set_int("music_player_enabled", 0)

      if music.players[dp] ~= nil then
	 core.sound_stop(music.players[dp]["handle"])
	 music.players[dp] = nil
      end
   end

   function music.start(pos)
      local dp = core.hash_node_position(pos)

      local meta = core.get_meta(pos)
      meta:set_string("infotext", "Music player (On)")
      meta:set_int("music_player_enabled", 1)

      if music.players[dp] == nil then
	 music.players[dp] = {
	    ["handle"] = core.sound_play(
	       music.default_track,
	       {
		  pos = pos,
		  gain = music.volume,
            }),
	    ["timer"] = 0,
	    ["pos"] = pos,
	 }
      else
	 music.players[dp]["timer"] = 0
	 core.sound_stop(music.players[dp]["handle"])
	 music.players[dp]["handle"] = core.sound_play(
	    music.default_track,
	    {
	       pos = pos,
	       gain = music.volume,
         })
      end
   end

   function music.update(pos)
      local dp = core.hash_node_position(pos)

      if music.players[dp] ~= nil then
	 local node = core.get_node(pos)

	 if node.name ~= "music:player" then
	    music.stop(pos)

	    return
	 end

	 if music.players[dp]["timer"] > music.track_length then
	    music.start(pos)
	 end
      end
   end

   function music.toggle(pos)
      local dp = core.hash_node_position(pos)

      if music.players[dp] == nil then
	 music.start(pos)
      else
	 music.stop(pos)
      end
   end

   core.register_node(
      "music:player",
      {
	 description = "Music player",

	 tiles = {"music_top.png", "music_bottom.png", "music_side.png"},

	 inventory_image = "music_inventory.png",
	 wield_image = "music_inventory.png",

	 paramtype = "light",

	 drawtype = "nodebox",
	 node_box = {
	    type = "fixed",
	    fixed = {-4/16, -0.5, -4/16, 4/16, -0.5 + (4/16), 4/16}
	 },

	 on_construct = function(pos)
            music.start(pos)
         end,

	 after_destruct = function(pos)
            music.stop(pos)
         end,

	 on_rightclick = function(pos)
            music.toggle(pos)
         end,

	 groups = {oddly_breakable_by_hand = 3}
   })

   function step(dtime)
      for dp, _ in pairs(music.players) do
	 music.players[dp]["timer"] = music.players[dp]["timer"] + dtime

	 music.update(music.players[dp]["pos"])
      end
   end

   core.register_globalstep(step)

   core.register_abm(
      {
	 nodenames = {"music:player"},
	 chance = 1,
	 interval = 1,
	 action = function(pos, node)
            if music.players[core.hash_node_position(pos)] == nil then
               local meta = core.get_meta(pos)
               if meta:get_int("music_player_enabled") == 1 then
                  music.start(pos)
               end
            end
         end
   })
else
   core.register_node(
      "music:player",
      {
	 description = "Music player",

	 tiles = {"music_top.png", "music_bottom.png", "music_side.png"},

	 inventory_image = "music_inventory.png",
	 wield_image = "music_inventory.png",

	 paramtype = "light",

	 drawtype = "nodebox",
	 node_box = {
	    type = "fixed",
	    fixed = {-4/16, -0.5, -4/16, 4/16, -0.5 + (4/16), 4/16}
	 },

	 on_construct = function(pos)
            local meta = core.get_meta(pos)

            meta:set_string("infotext", "Music player(Disabled by server)")
         end,

	 groups = {oddly_breakable_by_hand = 3}
   })
end

core.register_craft(
   {
      output = "music:player",
      recipe = {
	 {"group:planks", "group:planks", "group:planks"},
	 {"group:planks", "default:ingot_steel", "group:planks"},
      }
})

-- Achievements

achievements.register_achievement(
   "musician",
   {
      title = "Musician",
      description = "Craft a music player.",
      times = 1,
      craftitem = "music:player",
})

default.log("mod:music", "loaded")
