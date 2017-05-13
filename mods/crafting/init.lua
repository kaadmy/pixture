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

function crafting.craft(wanted, output, items)
   -- `output` can be any ItemStack value
   -- Duplicate items in `items` should work correctly

   local craftdef = crafting.registered_crafts[wanted:get_name()]

   if craftdef == nil then
      minetest.log("warning",
                   "Tried to craft an unregistered item " .. wanted:get_name())

      return nil
   end

   -- Check for validity

   local craft_count = wanted:get_count()

   for i = 1, crafting.max_inputs do
      local required_itemstack = ItemStack(craftdef.items[i])
      local itemc = 0

      local group = string.match(required_itemstack:get_name(), "group:(.*)")

      if required_itemstack ~= nil and required_itemstack:get_count() ~= 0 then
         for j = 1, crafting.max_inputs do
            local input_itemstack = ItemStack(items[j])

            if (group ~= nil
                   and minetest.get_item_group(input_itemstack:get_name(), group) ~= 0)
               or (input_itemstack ~= nil
                   and input_itemstack:get_name() == required_itemstack:get_name()) then
               itemc = itemc + input_itemstack:get_count()
            end
         end

         craft_count = math.min(craft_count, math.floor(itemc / required_itemstack:get_count()))

         if craft_count < 1 then
            minetest.log("warning",
                         "Not enough items to craft " .. wanted:to_string())

            return nil
         end
      end
   end

   -- Put stuff in output stack

   craft_count = math.min(craft_count, math.floor(output:get_free_space() / craft_count))

   if craft_count < 1 then
      minetest.log("warning",
                   "Output stack too full to hold " .. wanted:to_string())

      return nil
   end

   output:add_item(ItemStack({name = wanted:get_name(), count = wanted:get_count() * craft_count}))

   -- Iterate through second time to take items used for crafting

   local function remove_used_item(itemn, count)
      local items_required = count

      local group = string.match(itemn, "group:(.*)")

      for i = 1, crafting.max_inputs do
         local input_itemstack = ItemStack(items[i])

         if (group ~= nil
                and minetest.get_item_group(input_itemstack:get_name(), group) ~= 0)
            or (items[i] ~= nil
                and input_itemstack:get_name() == itemn) then
            local items_left = items_required - input_itemstack:get_count()

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

   return {items = items, output = output}
end

local form_crafting = default.ui.get_page("default:2part")

form_crafting = form_crafting .. "list[current_player;main;0.25,4.75;8,4;]"
form_crafting = form_crafting .. "listring[current_player;main]"
form_crafting = form_crafting .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_crafting = form_crafting .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)

form_crafting = form_crafting .. "list[current_player;craft_in;0.25,0.25;1,4;]"
form_crafting = form_crafting .. "listring[current_player;craft_in]"

form_crafting = form_crafting .. "list[current_player;craft_out;7.25,0.25;1,1;]"

form_crafting = form_crafting .. default.ui.get_itemslot_bg(0.25, 0.25, 1, 4)
form_crafting = form_crafting .. default.ui.get_itemslot_bg(7.25, 0.25, 1, 1)

form_crafting = form_crafting .. "image[7.25,1.25;1,1;ui_arrow_bg.png]"

form_crafting = form_crafting .. default.ui.button(7.25, 2.25, 1, 1, "do_craft_1", "1")
form_crafting = form_crafting .. default.ui.button(7.25, 3.25, 1, 1, "do_craft_10", "10")

default.ui.register_page("crafting:crafting", form_crafting)

function crafting.get_formspec(name)
   local form = default.ui.get_page("crafting:crafting")

   return form
end

local function on_joinplayer(player)
   local inv = player:get_inventory()

   if inv:get_size("craft_in") ~= 4 then
      inv:set_size("craft_in", 4)
   end

   if inv:get_size("craft_out") ~= 1 then
      inv:set_size("craft_out", 1)
   end
end

local function on_player_receive_fields(player, form_name, fields)
   if form_name ~= "crafting:crafting" then
      return
   end

   local inv = player:get_inventory()

   local wanted_itemstack = ItemStack("default:stone 2")
   local output_itemstack = inv:get_stack("craft_out", 1)

   if output_itemstack:get_name() ~= wanted_itemstack:get_name() and output_itemstack:get_count() ~= 0 then
      minetest.log("warning", "Trying to craft " .. wanted_itemstack:to_string() .. " but output has too many/different items")
   end

   if fields.do_craft_1 then
      wanted_itemstack:set_count(1)
   elseif fields.do_craft_10 then
      wanted_itemstack:set_count(2)
   else
      return
   end

   local crafted = crafting.craft(wanted_itemstack, output_itemstack, inv:get_list("craft_in"))

   if crafted and inv:room_for_item("craft_out", crafted.output) then
      inv:add_item("craft_out", crafted.output)

      inv:set_list("craft_in", crafted.items)
   end
end

minetest.register_on_joinplayer(on_joinplayer)
minetest.register_on_player_receive_fields(on_player_receive_fields)

crafting.register_craft(
   "default:stone 4",
   {
      items = {
         {name = "default:stick", count = 3},
         {name = "default:fiber", count = 2},
         {name = "group:stone", count = 2},
      },
})

default.log("mod:crafting", "loaded")
