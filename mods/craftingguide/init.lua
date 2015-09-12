--
-- Crafting guide mod
-- By Kaadmy, for Pixture
--

craftingguide = {}
craftingguide.items = {}
craftingguide.itemlist = {}
craftingguide.users = {} -- {item = selected item, itemno = recipe no., page = page no.}

local page_size = 8 * 4

function craftingguide.get_formspec(name)
   local user = craftingguide.users[name]

   local page = user.page
   local max_pages = math.floor(#craftingguide.itemlist / page_size) + 1

   local form = ""
   form = form .. default.ui.get_page("core_craftingguide")

   form = form .. "label[0.41,1.74;"..user.itemno.."/"..#craftingguide.items[user.item].."]" -- itemno
   form = form .. "label[3.9,8.15;"..page.."/"..max_pages.."]" -- page
   form = form .. "label[4.4,2.5;"..user.item.."]" -- itemname
   
   local method = craftingguide.items[user.item][user.itemno].type
   if method == "normal" or method == "crafting" then
      form = form .. "image[4.25,1.5;1,1;craftingguide_method_crafting.png]"
   elseif method == "cooking" then
      form = form .. "image[4.25,1.5;1,1;craftingguide_method_cooking.png]"
-- fuel recipes are different
--   elseif method == "fuel" then
--      form = form .. "image[4.25,1.5;1,1;craftingguide_method_fuel.png]"
   else
      form = form .. "image[4.25,1.5;1,1;craftingguide_method_unknown.png]"
      form = form .. "label[4.1,1.73;"..method.."]"
   end
   
   form = form .. default.ui.fake_itemstack(6.25, 1.5, ItemStack(user.item), "guide_craftresult")

   local recipes = craftingguide.items[user.item]
   local recipe = recipes[user.itemno]

--   print(dump(recipe))
   for slot_index, itemname in pairs(recipe.items) do
      local x = slot_index - 1

      local group = string.match(itemname, "group:(.*)")

      if group == nil then
	 form = form .. default.ui.fake_simple_itemstack(1.25 + (x % 3), 0.5 + math.floor(x / 3), itemname, "guide_craftgrid_"..itemname)
      else
	 form = form .. default.ui.item_group(1.25 + (x % 3), 0.5 + math.floor(x / 3), group, "guide_craftgrid_"..itemname)
      end
   end

   local page_start = ((page * page_size) - page_size) + 1

   local inv_x = 0
   local inv_y = 0

   for item_index = page_start, (page_start + page_size) - 1 do
      local recipes = craftingguide.items[craftingguide.itemlist[item_index]]

      if recipes ~= nil then
	 local itemname = ItemStack(recipes[1].output):get_name()

	 form = form .. default.ui.fake_simple_itemstack(0.25 + inv_x, 4 + inv_y, itemname, "guide_item_"..itemname)

	 inv_x = inv_x + 1
	 if inv_x >= 8 then
	       inv_x = 0
	    inv_y = inv_y + 1
	 end	 
      else
	 break
      end
   end

   return form
end

local function receive_fields(player, form_name, fields)
   if form_name == "core_craftingguide" and not fields.quit then
      local name = player:get_player_name()
      local user = craftingguide.users[name]

      local page = user.page
      local recipes = craftingguide.items[user.item]
      local itemno = user.itemno

      local max_pages = math.floor(#craftingguide.itemlist / page_size) + 1

      if fields.guide_next_recipe and itemno < #recipes then
	 itemno = itemno + 1
      elseif fields.guide_prev_recipe and itemno > 1 then
	 itemno = itemno - 1
      end
	 

      if fields.guide_next and page < max_pages then
	 page = page + 1
      elseif fields.guide_prev and page > 1 then
	 page = page - 1
      end

      for fieldname, val in pairs(fields) do
	 local itemname = string.match(fieldname, "guide_item_(.*)")

	 if itemname ~= nil then
	    craftingguide.users[name].item = itemname
	    craftingguide.users[name].itemno = 1
	 end
      end

      craftingguide.users[name].page = page
      craftingguide.users[name].itemno = itemno

      minetest.show_formspec(name, "core_craftingguide", craftingguide.get_formspec(name))
   end
end

local function on_joinplayer(player)
   local name = player:get_player_name()

   craftingguide.users[name] = {page = 1, item = craftingguide.itemlist[1], itemno = 1}
end

local function on_leaveplayer(player)
   local name = player:get_player_name()
   
   craftingguide.users[name] = nil
end

local function load_recipes()
   for itemname, itemdef in pairs(minetest.registered_items) do
      local recipes = minetest.get_all_craft_recipes(itemname)
      
      if recipes ~= nil and itemname ~= "" and minetest.get_item_group(itemname, "not_in_craftingguide") ~= 1 then
--	 print(dump(recipes))
	 craftingguide.items[itemname] = recipes
	 table.insert(craftingguide.itemlist, itemname)
      end
   end

   table.sort(craftingguide.itemlist)

   print("Got "..#craftingguide.itemlist.." craftable items")
end

minetest.after(0, load_recipes)

minetest.register_on_joinplayer(on_joinplayer)
minetest.register_on_leaveplayer(on_leaveplayer)
minetest.register_on_player_receive_fields(receive_fields)

local form_craftingguide = default.ui.get_page("core")
form_craftingguide = form_craftingguide .. default.ui.get_itemslot_bg(0.25, 4, 8, 4)
form_craftingguide = form_craftingguide .. default.ui.image_button(2.5, 7.9, 1, 1, "guide_prev", "ui_arrow_bg.png^[transformR90")
form_craftingguide = form_craftingguide .. default.ui.image_button(5, 7.9, 1, 1, "guide_next", "ui_arrow_bg.png^[transformR270")

form_craftingguide = form_craftingguide .. default.ui.image_button(0.25, 0.5, 1, 1, "guide_next_recipe", "ui_arrow_bg.png")
form_craftingguide = form_craftingguide .. default.ui.image_button(0.25, 2.5, 1, 1, "guide_prev_recipe", "ui_arrow_bg.png^[transformFY")
form_craftingguide = form_craftingguide .. default.ui.get_itemslot_bg(1.25, 0.5, 3, 3)
form_craftingguide = form_craftingguide .. default.ui.get_itemslot_bg(6.25, 1.5, 1, 1)
form_craftingguide = form_craftingguide .. "image[5.25,1.5;1,1;"..minetest.formspec_escape("ui_arrow.png^[transformR270").."]"

default.ui.register_page("core_craftingguide", form_craftingguide)