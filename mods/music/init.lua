--
-- Music player mod
-- By Kaadmy, for Pixture
--

music = {}

music.players = {} -- music players

if minetest.setting_getbool("music_enable") then
   function music.stop(pos)
      local dp = default.dumpvec(pos)

      local meta = minetest.get_meta(pos)
      meta:set_string("infotext", "Music player(Off)")
      meta:set_int("music_player_enabled", 0)

      if music.players[dp] ~= nil then
	 minetest.sound_stop(music.players[dp]["handle"])
	 music.players[dp] = nil
      end
   end
   
   function music.start(pos)
      local dp = default.dumpvec(pos)

      local meta = minetest.get_meta(pos)
      meta:set_string("infotext", "Music player(On)")
      meta:set_int("music_player_enabled", 1)

      if music.players[dp] == nil then
	 music.players[dp] = {
	    ["handle"] = minetest.sound_play(
	       "music_catsong",
	       {
		  pos = pos,
		  gain = 0.5,
	       }),
	    ["timer"] = 0,
	    ["pos"] = pos,
	 }
      else
	 music.players[dp]["timer"] = 0
	 minetest.sound_stop(music.players[dp]["handle"])
	 music.players[dp]["handle"] = minetest.sound_play(
	    "music_catsong",
	    {
	       pos = pos,
	       gain = 0.5,
	    })
      end
   end

   function music.update(pos)
      local dp = default.dumpvec(pos)

      if music.players[dp] ~= nil then
	 local node = minetest.get_node(pos)

	 if node.name ~= "music:player" then
	    music.stop(pos)

	    return
	 end

	 if music.players[dp]["timer"] > 28 then
	    music.start(pos)
	 end
      end
   end

   function music.toggle(pos)
      local dp = default.dumpvec(pos)
      
      if music.players[dp] == nil then
	 music.start(pos)
      else
	 music.stop(pos)
      end
   end

   minetest.register_node(
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

   minetest.register_globalstep(step)

   minetest.register_abm(
      {
	 nodenames = {"music:player"},
	 chance = 1,
	 interval = 1,
	 action = function(pos, node)
		     if music.players[default.dumpvec(pos)] == nil then
			local meta = minetest.get_meta(pos)
			if meta:get_int("music_player_enabled") == 1 then
			   music.start(pos)
			end
		     end
		  end
      })
else
   minetest.register_node(
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
			   local meta = minetest.get_meta(pos)

			   meta:set_string("infotext", "Music player(Disabled by server)")
			end,

	 groups = {oddly_breakable_by_hand = 3}
      })
end

minetest.register_craft(
   {
      output = "music:player",
      recipe = {
	 {"group:planks", "group:planks", "group:planks"},
	 {"group:planks", "default:ingot_steel", "group:planks"},
      }
   })