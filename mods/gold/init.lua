--
-- Gold and NPC Trading
-- By Kaadmy, for Pixture
--

gold = {}

gold.pr = PseudoRandom(minetest.get_mapgen_params().seed+8732)

gold.trades = {}
gold.trade_names = {}

if minetest.get_modpath("mobs") ~= nil then
   gold.trades["farmer"] = {
      -- plants
      {"gold:gold", "", "farming:wheat_1 6"},
      {"gold:gold 3", "", "farming:cotton_1 4"},
      {"gold:gold 5", "", "farming:cotton_1 8"},
      {"gold:gold", "", "default:papyrus 4"},
      {"gold:gold 4", "", "default:cactus 2"},

      -- crafts
      {"gold:gold 7", "", "farming:cotton_bale 3"},

      -- materials
      {"default:planks 3", "farming:cotton_bale 3", "bed:bed"},

      -- tool repair
      {"gold:gold 6", "default:shovel_stone", "default:shovel_stone"},
      {"gold:gold 8", "default:shovel_steel", "default:shovel_steel"},
      {"gold:gold 10", "default:shovel_carbonsteel", "default:shovel_carbonsteel"},
   }
   gold.trades["tavernkeeper"] = {
      -- materials
      {"gold:gold 2", "", "default:planks 12"},
      {"gold:gold 2", "", "default:planks_birch 8"},

      -- useables
      {"gold:gold 9", "", "bed:bed"},
      {"gold:gold 5", "", "default:chest"},
      {"default:planks_birch 3", "mobs:wool 3", "bed:bed"},

      -- filling buckets
      {"gold:gold", "default:bucket", "default:bucket_water"},
   }
   gold.trades["blacksmith"] = {
      -- smeltables
      {"gold:gold", "", "default:lump_coal"},
      {"gold:gold 3", "", "default:lump_iron"},
      {"gold:gold 5", "", "default:dust_carbonsteel"},

      -- materials
      {"gold:gold 2", "", "default:cobble 10"},
      {"gold:gold 3", "", "default:stone 10"},
      {"gold:gold 5", "", "default:reinforced_cobble 10"},
      {"gold:gold 25", "", "default:block_steel"},
      {"gold:gold 6", "", "default:glass 5"},

      -- usebles
      {"gold:gold 7", "", "default:furnace"},

      -- ingots
      {"gold:gold 5", "", "default:ingot_steel"},
      {"gold:gold 8", "", "default:ingot_carbonsteel"},

      -- auto smelting
      {"gold:gold 2", "default:lump_iron", "default:ingot_steel"},
      {"gold:gold 4", "default:dust_carbonsteel", "default:ingot_carbonsteel"},

      -- tool repair
      {"gold:gold 8", "default:pick_stone", "default:pick_stone"},
      {"gold:gold 12", "default:pick_steel", "default:pick_steel"},
      {"gold:gold 16", "default:pick_carbonsteel", "default:pick_carbonsteel"},
   }
   gold.trades["butcher"] = {
      -- materials
      {"gold:gold 3", "", "default:planks_oak 10"},

      -- cooked edibles
      {"gold:gold 2", "", "mobs:meat"},
      {"gold:gold 3", "", "mobs:pork"},

      -- raw edibles
      {"gold:gold 2", "", "mobs:meat_raw 2"},
      {"gold:gold 3", "", "mobs:pork_raw 2"},

      -- cooking edibles
      {"gold:gold 1", "mobs:meat_raw", "mobs:meat"},
      {"gold:gold 2", "mobs:pork_raw", "mobs:pork"},

      -- tool repair
      {"gold:gold 5", "default:spear_stone", "default:spear_stone"},
      {"gold:gold 7", "default:spear_steel", "default:spear_steel"},
      {"gold:gold 11", "default:spear_carbonsteel", "default:spear_carbonsteel"},

   }
   -- trading currency
   if minetest.get_modpath("jewels") ~= nil then -- jewels/gold
      --farmer
      table.insert(gold.trades["farmer"], {"gold:gold 16", "", "jewels:jewel"})
      table.insert(gold.trades["farmer"], {"gold:gold 22", "", "jewels:jewel 2"})
      table.insert(gold.trades["farmer"], {"gold:gold 34", "", "jewels:jewel 4"})

      table.insert(gold.trades["farmer"], {"jewels:jewel", "", "gold:gold 14"})
      table.insert(gold.trades["farmer"], {"jewels:jewel 2", "", "gold:gold 20"})
      table.insert(gold.trades["farmer"], {"jewels:jewel 4", "", "gold:gold 32"})

      table.insert(gold.trades["farmer"], {"default:planks 6", "", "gold:gold"})

      -- tavern keeper
      table.insert(gold.trades["tavernkeeper"], {"gold:gold 14", "", "jewels:jewel"})
      table.insert(gold.trades["tavernkeeper"], {"gold:gold 20", "", "jewels:jewel 2"})
      table.insert(gold.trades["tavernkeeper"], {"gold:gold 32", "", "jewels:jewel 4"})

      -- blacksmith
      table.insert(gold.trades["blacksmith"], {"default:ingot_steel 14", "", "jewels:jewel"})
      table.insert(gold.trades["blacksmith"], {"default:ingot_steel 20", "", "jewels:jewel 2"})
      table.insert(gold.trades["blacksmith"], {"default:ingot_steel 32", "", "jewels:jewel 4"})
   end

   -- butcher(no mod check)
   table.insert(gold.trades["butcher"], {"mobs:meat_raw 3", "", "gold:gold"})
   table.insert(gold.trades["butcher"], {"mobs:meat_raw 4", "", "gold:gold 2"})
   table.insert(gold.trades["butcher"], {"mobs:meat_raw 5", "", "gold:gold 4"})

   gold.trade_names["farmer"] = "Farmer"
   gold.trade_names["tavernkeeper"] = "Tavern Keeper"
   gold.trade_names["blacksmith"] = "Blacksmith"
   gold.trade_names["butcher"] = "Butcher"
end

local form_trading = ""

form_trading = form_trading .. default.ui.get_page("core_2part")

form_trading = form_trading .. "list[current_player;gold_trade_out;3.75,2.25;1,1;]"
form_trading = form_trading .. "listring[current_player;gold_trade_out]"

form_trading = form_trading .. default.ui.get_hotbar_itemslot_bg(3.75, 2.25, 1, 1)

form_trading = form_trading .. "list[current_player;main;0.25,4.75;8,4;]"
form_trading = form_trading .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_trading = form_trading .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)

form_trading = form_trading .. "list[current_player;gold_trade_in;6.25,1.25;1,2;]"
form_trading = form_trading .. "listring[current_player;gold_trade_in]"
form_trading = form_trading .. default.ui.get_itemslot_bg(6.25, 1.25, 1, 2)

form_trading = form_trading .. "image[2.5,1.25;1,1;ui_arrow_bg.png^[transformR270]"
form_trading = form_trading .. "image[5,2.25;1,1;ui_arrow.png^[transformR90]"

form_trading = form_trading .. default.ui.button_exit(1.25, 3.25, 2, 1, "cancel", "Cancel")
form_trading = form_trading .. default.ui.button(5.25, 3.25, 2, 1, "trade", "Trade")

default.ui.register_page("gold_trading_book", form_trading)

function gold.trade(trade, trade_type, player)
   local name = player:get_player_name()
   local item = player:get_wielded_item()

   if item:get_name() ~= "gold:trading_book" then return end

   local inv = player:get_inventory()
   
   if inv:get_size("gold_trade_wanted") ~= 2 then
      inv:set_size("gold_trade_wanted", 2)
   end
   
   if inv:get_size("gold_trade_out") ~= 1 then
      inv:set_size("gold_trade_out", 1)
   end

   if inv:get_size("gold_trade_in") ~= 2 then
      inv:set_size("gold_trade_in", 2)
   end
   
   inv:set_stack("gold_trade_wanted", 1, trade[1])
   inv:set_stack("gold_trade_wanted", 2, trade[2])
   
   local meta = minetest.deserialize(item:get_metadata())

   if not meta then meta = {} end
   meta.trade = trade

   local trade_name = gold.trade_names[trade_type]

   local trade_wanted1 = inv:get_stack("gold_trade_wanted", 1)
   local trade_wanted2 = inv:get_stack("gold_trade_wanted", 2)

   local form = default.ui.get_page("gold_trading_book")
   form = form .. "label[0.25,0.25;"..minetest.formspec_escape(trade_name).."]"

   form = form .. default.ui.fake_itemstack(1.25, 1.25, trade_wanted1, "trade_wanted1")
   form = form .. default.ui.fake_itemstack(1.25, 2.25, trade_wanted2, "trade_wanted2")
   form = form .. default.ui.fake_itemstack(3.75, 1.25, ItemStack(trade[3]), "vistrade_result")

   minetest.show_formspec(name, "gold:trading_book", form)

   meta.trade_type = trade_type

   item:set_metadata(minetest.serialize(meta))
   player:set_wielded_item(item)
end

minetest.register_on_player_receive_fields(
   function(player, form_name, fields)
      if form_name ~= "gold:trading_book" or fields.cancel then return end

      local inv = player:get_inventory()

      if fields.trade then
	 local item = player:get_wielded_item()

	 local trade_wanted1 = inv:get_stack("gold_trade_wanted", 1):to_string()
	 local trade_wanted2 = inv:get_stack("gold_trade_wanted", 2):to_string()

	 local trade_in1 = inv:get_stack("gold_trade_in", 1):to_string()
	 local trade_in2 = inv:get_stack("gold_trade_in", 2):to_string()
	 
	 local matches = trade_wanted1 == trade_in1 and trade_wanted2 == trade_in2

	 local meta = minetest.deserialize(item:get_metadata())
	 
	 local trade = {"gold:gold", "gold:gold", "default:stick"}
	 local trade_type = ""
	 
	 if meta then
	    trade = meta.trade
	    trade_type = meta.trade_type
	 end

	 if matches then
	    if inv:room_for_item("gold_trade_out", trade[3]) then
	       inv:add_item("gold_trade_out", trade[3])
	       inv:set_stack("gold_trade_in", 1, "")
	       inv:set_stack("gold_trade_in", 2, "")	       
	    end
	 end
      end
   end)

minetest.register_craftitem(
   "gold:trading_book",
   {
      description = "Trading Book",
      inventory_image = "default_book.png^gold_bookribbon.png",
      stack_max = 1,
   })

minetest.register_craftitem(
   "gold:gold",
   {
      description = "Gold",
      inventory_image = "gold_gold.png",
      stack_max = 120
   })

minetest.register_alias("gold", "gold:gold")

minetest.register_node(
   "gold:ore",
   {
      description = "Gold Ore",
      tiles ={"default_stone.png^gold_mineral.png"},
      groups = {cracky=1, stone=1},
      drop = "gold:gold",
      is_ground_content = true,
      sounds = default.node_sound_stone_defaults(),
   })

minetest.register_ore(
   {
      ore_type       = "scatter",
      ore            = "gold:ore",
      wherein        = "default:stone",
      clust_scarcity = 12*12*12,
      clust_num_ores = 10,
      clust_size     = 10,
      height_min     = -256,
      height_max     = -32,
   })