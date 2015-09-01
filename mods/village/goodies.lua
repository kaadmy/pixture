--
-- Goodies for filling inventories with!
-- Should work with any node with inventory metadata given the correct parameters
--

village.goodies = {}

village.goodies.max_stack = 8
village.goodies.max_items = 20

village.goodies.types = {}
-- custom types
village.goodies.types["FURNACE_SRC"]  = {
   ["default:lump_iron"] = 3,
   ["default:dust_carbonsteel"] = 8,
   ["farming:flour"] = 5,
}
village.goodies.types["FURNACE_FUEL"]  = {
   ["default:lump_coal"] = 2,
   ["default:planks_oak"] = 4,
   ["default:planks_birch"] = 5,
}
village.goodies.types["FURNACE_DST"]  = {
   ["default:ingot_steel"] = 5,
   ["default:ingot_carbonsteel"] = 12,
   ["farming:bread"] = 8,
}

-- chunk types
village.goodies.types["forge"]  = {
   ["default:ingot_steel"] = 10,
   ["default:lump_coal"] = 4,
   ["default:lump_iron"] = 6,
   ["default:dust_carbonsteel"] = 18,
   ["default:pick_stone"] = 9,
   ["default:tree_oak"] = 2,
}
village.goodies.types["tavern"] = {
   ["bed:bed"] = 8,
   ["default:bucket"] = 20,
   ["mobs:meat"] = 5,
   ["mobs:pork"] = 9,
   ["default:ladder"] = 9,
}
village.goodies.types["house"]  = {
   ["default:stick"] = 2,
   ["farming:bread"] = 6,
   ["farming:cotton_1"] = 9,
   ["farming:wheat_1"] = 6,
   ["default:axe_stone"] = 13,
   ["default:apple"] = 3,
   ["default:bucket"] = 8,
   ["default:bucket_water"] = 12,
}

function village.goodies.fill(pos, ctype, pr, listname, keepchance)
   -- fill an inventory with a specified type's goodies
   if village.goodies.types[ctype] == nil then return end

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
      local chance = village.goodies.types[ctype][util.choice(village.goodies.types[ctype], pr)]
      local item = util.choice(village.goodies.types[ctype], pr)
      if pr:next(1, chance) <= 1 then
	 local itemstr = item.." "..pr:next(1, village.goodies.max_stack)
	 inv:set_stack(listname, pr:next(1, size), ItemStack(itemstr))
      end
   end
end
