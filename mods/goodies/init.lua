--
-- Goodies mod
-- By Kaadmy
--

goodies = {}

goodies.max_stack = 6
goodies.max_items = 20

goodies.types = {}
-- custom types
goodies.types["FURNACE_SRC"]  = {
   ["default:lump_iron"] = 3,
   ["default:dust_carbonsteel"] = 8,
   ["farming:flour"] = 5,
}
goodies.types["FURNACE_FUEL"]  = {
   ["default:lump_coal"] = 2,
   ["default:planks_oak"] = 4,
   ["default:planks_birch"] = 5,
}
goodies.types["FURNACE_DST"]  = {
   ["default:ingot_steel"] = 5,
   ["default:ingot_carbonsteel"] = 12,
   ["farming:bread"] = 8,
}

-- chunk types for villages
if minetest.get_modpath("village") ~= nil then
   goodies.types["forge"]  = {
      ["default:ingot_steel"] = 10,
      ["default:lump_coal"] = 4,
      ["default:lump_iron"] = 6,
      ["default:dust_carbonsteel"] = 18,
      ["default:pick_stone"] = 9,
      ["default:tree_oak"] = 2,
   }
   goodies.types["tavern"] = {
      ["bed:bed"] = 8,
      ["default:bucket"] = 20,
      ["mobs:meat"] = 5,
      ["mobs:pork"] = 9,
      ["default:ladder"] = 9,
   }
   goodies.types["house"]  = {
      ["default:stick"] = 2,
      ["farming:bread"] = 6,
      ["farming:cotton_1"] = 9,
      ["farming:wheat_1"] = 6,
      ["default:axe_stone"] = 13,
      ["default:apple"] = 3,
      ["default:bucket"] = 8,
      ["default:bucket_water"] = 12,
   }

   -- jewels and gold
   if minetest.get_modpath("jewels") ~= nil then
      goodies.types["house"]["jewels:bench"] = 24 -- jeweling benches
      goodies.types["house"]["jewels:jewel"] = 34
      goodies.types["tavern"]["jewels:jewel"] = 32
      goodies.types["forge"]["jewels:jewel"] = 30
   end
   if minetest.get_modpath("gold") ~= nil then
      goodies.types["house"]["gold:gold"] = 12
      goodies.types["tavern"]["gold:gold"] = 10
      goodies.types["forge"]["gold:gold"] = 8
   end
end

function goodies.fill(pos, ctype, pr, listname, keepchance)
   -- fill an inventory with a specified type's goodies

   if goodies.types[ctype] == nil then return end

   if pr:next(1, keepchance) ~= 1 then
      minetest.remove_node(pos)
      return
   end

   local meta = minetest.get_meta(pos)
   local inv = meta:get_inventory()
   
   local size = inv:get_size(listname)

   if size < 1 then return end

   local item_amt = pr:next(1, size)

   for i = 1, item_amt do
      local chance = goodies.types[ctype][util.choice(goodies.types[ctype], pr)]
      local item = util.choice(goodies.types[ctype], pr)
      if pr:next(1, chance) <= 1 then
	 local itemstr = item.." "..pr:next(1, goodies.max_stack)
	 inv:set_stack(listname, pr:next(1, size), ItemStack(itemstr))
      end
   end
end
