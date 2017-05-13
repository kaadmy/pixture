--
-- Crafting mod
-- By Kaadmy, for Pixture
--

crafting = {}

crafting.registered_crafts = {}

-- Crafting can only take 4 itemstacks as input for sanity/interface reasons
crafting.max_inputs = 4

-- Default crafting definition values
crafting.default_craftdef = {
   output = nil,
   description = "",
   items = {},
   groups = {},
}

function crafting.register_craft(output, def)
   -- `output` can be any ItemStack value, but count is NOT used

   local itemstack = ItemStack(output)
   local itemn = itemstack:get_name()

   if crafting.registered_crafts[itemn] ~= nil then
      minetest.log("warning",
                   "Tried to register an existing craft " .. itemn)

      return
   end

   local craftdef = {
      output = itemstack,
      description = def.description or minetest.registered_items[itemn].description,
      items = def.items or crafting.default_craftdef.items,
      groups = def.groups or crafting.default_craftdef.groups,
   }

   if #craftdef.items > 4 then
      minetest.log("warning",
                   "Attempting to register craft " .. itemn .." with more than "
                      .. crafting.max_inputs .. " inputs, keeping")
   end

   for i = 1, crafting.max_inputs do
      craftdef.items[i] = ItemStack(craftdef.items[i])
   end

   crafting.registered_crafts[itemn] = craftdef

   minetest.log("info", "Registered recipe for " .. itemn .. ": " .. dump(crafting.registered_crafts[itemn]))
end

function crafting.craft(output, items)
   -- `output` can be any ItemStack value
   -- Duplicate items in `items` should work correctly

   print(dump(output))

   local wanted_itemstack = ItemStack(output)

   print(dump(wanted_itemstack:to_string()))

   local craftdef = crafting.registered_crafts[wanted_itemstack:get_name()]

   if craftdef == nil then
      minetest.log("warning",
                   "Tried to craft an unregistered item " .. wanted_itemstack:get_name())

      return nil
   end

   --print("Craftdef items: " .. dump(craftdef.items))
   print("Input before: " .. dump(items))

   -- Check for validity

   local craft_count = wanted_itemstack:get_count()

   for i = 1, crafting.max_inputs do
      local required_itemstack = ItemStack(craftdef.items[i])
      local itemc = 0

      if required_itemstack ~= nil and required_itemstack:get_count() ~= 0 then
         for j = 1, crafting.max_inputs do
            local input_itemstack = ItemStack(items[j])

            if input_itemstack:get_name() == required_itemstack:get_name() then
               itemc = itemc + input_itemstack:get_count()
            end
         end

         craft_count = math.min(craft_count, math.floor(itemc / required_itemstack:get_count()))

         if craft_count < 1 then
            minetest.log("warning",
                         "Not enough items to craft " .. wanted_itemstack:get_name())

            return nil -- Not enough items
         end
      end
   end

   --print("Craft count: " .. craft_count .. "/" .. output.count)

   -- Iterate through second time to take items used for crafting

   local function remove_used_item(itemn, count)
      local items_required = count

      for i = 1, crafting.max_inputs do
         local input_itemstack = ItemStack(items[i])

         if items[i] ~= nil and input_itemstack:get_name() == itemn then
            local items_left = items_required - input_itemstack:get_count()

            print("Taking " .. items_required .. " items from " .. itemn)

            input_itemstack:take_item(items_required)

            if items_left > 0 then
               items_required = items_required - (items_required - items_left)
            else
               items[i] = input_itemstack:to_table()
               break
            end

            items[i] = input_itemstack:to_table()
         end
      end
   end

   for i = 1, crafting.max_inputs do
      local required_itemstack = ItemStack(craftdef.items[i])

      if craftdef.items[i] ~= nil then
         remove_used_item(required_itemstack:get_name(), required_itemstack:get_count() * craft_count)
      end
   end

   print("Input after: " .. dump(items))

   return items
end

local form = default.ui.get_page("default:2part")
form = form .. "list[current_player;main;0.25,4.75;8,4;]"
form = form .. "listring[current_player;main]"
form = form .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form = form .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)

form = form .. "list[current_player;craft;2.25,0.75;3,3;]"
form = form .. "listring[current_player;craft]"

form = form .. "image[5.25,1.75;1,1;ui_arrow_bg.png^[transformR270]"

form = form .. "list[current_player;craftpreview;6.25,1.75;1,1;]"
form = form .. default.ui.get_itemslot_bg(2.25, 0.75, 3, 3)
form = form .. default.ui.get_itemslot_bg(6.25, 1.75, 1, 1)
default.ui.register_page("crafting:crafting", form)

function crafting.get_formspec(name)
   local form = default.ui.get_page("crafting:crafting")

   return form
end

crafting.register_craft(
   "default:stone 4",
   {
      items = {
         {name = "default:stick", count = 3},
         {name = "default:fiber", count = 2},
         {name = "group:stone", count = 2},
      },
})

crafting.craft(
   "default:stone 2",
   {
      "default:stick 4", -- 0 leftover
      {name = "default:stick", count = 5}, -- 3 leftover
      "default:fiber 9", -- 5 leftover
      {name = "group:stone", count = 4}, -- 0 leftover
})

local function on_player_recieve_fields(player, form_name, fields)
   if form_name ~= "core:crafting" or fields.cancel then return end

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
end

minetest.register_on_player_receive_fields(on_player_recieve_fields)

default.log("mod:crafting", "loaded")
