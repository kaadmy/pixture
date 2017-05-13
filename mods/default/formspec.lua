default.ui = {}

default.ui.default = {}

default.ui.default.colors = "listcolors[#00000000;#00000010;#00000000;#68B259;#FFF]"
default.ui.default.bg = "bgcolor[#00000000;false]"

function default.ui.get_itemslot_bg(x, y, w, h)
   local out = ""
   for i = 0, w - 1, 1 do
      for j = 0, h - 1, 1 do
	 out = out .."image["..x+i..","..y+j..";1,1;ui_itemslot.png]"
      end
   end
   return out
end

function default.ui.get_hotbar_itemslot_bg(x, y, w, h)
   local out = ""
   for i = 0, w - 1, 1 do
      for j = 0, h - 1, 1 do
	 out = out .."image["..x+i..","..y+j..";1,1;ui_itemslot.png^ui_itemslot_dark.png]"
      end
   end
   return out
end

function default.ui.image_button(x, y, w, h, name, image)
   local image = minetest.formspec_escape(image)

   return "image_button["..x..","..y..";"..w..","..h..";"..image..";"..name..";;;false;"..image.."]"
end

function default.ui.button(x, y, w, h, name, label, noclip)
   local nc = "false"

   if noclip then
      nc = "true"
   end

   if w == 2 then
      return "image_button["..x..","..y..";"..w..","..h..";ui_button_2w_inactive.png;"..name..";"..label..";"..nc..";false;ui_button_2w_active.png]"
   else
      return "image_button["..x..","..y..";"..w..","..h..";ui_button_3w_inactive.png;"..name..";"..label..";"..nc..";false;ui_button_3w_active.png]"
   end
end

function default.ui.button_exit(x, y, w, h, name, label, noclip)
   local nc = "false"

   if noclip then
      nc = "true"
   end

   if w == 2 then
      return "image_button_exit["..x..","..y..";"..w..","..h..";ui_button_2w_inactive.png;"..name..";"..label..";"..nc..";false;ui_button_2w_active.png]"
   else
      return "image_button_exit["..x..","..y..";"..w..","..h..";ui_button_3w_inactive.png;"..name..";"..label..";"..nc..";false;ui_button_3w_active.png]"
   end
end

function default.ui.tab(x, y, name, icon, tooltip)
   local tooltip = tooltip or ""
   local shifted_icon = "[combine:16x16:0,0=ui_tab_active.png:0,1="..icon

   local form = ""
   form = form .. "image_button["..x..","..y..";1,1;ui_tab_inactive.png^"..icon..";"..name..";;true;false;"..minetest.formspec_escape(shifted_icon).."]"
   form = form .. "tooltip["..name..";"..tooltip.."]"

   return form
end

local function get_itemdef_field(itemname, fieldname)
   if not minetest.registered_items[itemname] then
      return nil
   end
   return minetest.registered_items[itemname][fieldname]
end

function default.ui.fake_itemstack(x, y, itemstack, name)
   local name = name or "fake_itemstack"

   local itemname = itemstack:get_name()
   local itemamt = itemstack:get_count()

   local itemdesc = ""
   if minetest.registered_items[itemname] and minetest.registered_items[itemname].description ~= nil then
      itemdesc = minetest.registered_items[itemname].description
   end

   if itemamt <= 1 then itemamt = "" end

   local result = ""
   if itemname ~= "" then
      --      result = result .. "image_button["..x..","..y..";1,1;"..itemimage..";"..name..";;false;false;"..itemimage.."]"
      result = result .. "image_button["..x..","..y..";1,1;ui_null.png;"..name..";;false;false;ui_null.png]"
      result = result .. "item_image["..x..","..y..";1,1;"..minetest.formspec_escape(itemname).."]"
      result = result .. "label["..(x+0.6)..","..(y+0.5)..";"..itemamt.."]"
      result = result .. "tooltip["..name..";"..itemdesc.."]"
   end

   return result
end

function default.ui.fake_simple_itemstack(x, y, itemname, name)
   local name = name or "fake_simple_itemstack"

   local itemdesc = ""
   if minetest.registered_items[itemname] and minetest.registered_items[itemname].description ~= nil then
      itemdesc = minetest.registered_items[itemname].description
   end

   local result = ""
   if itemname ~= "" then
      --      result = result .. "image_button["..x..","..y..";1,1;"..itemimage..";"..name..";;false;false;"..itemimage.."]"
      result = result .. "image_button["..x..","..y..";1,1;ui_null.png;"..name..";;false;false;ui_null.png]"
      result = result .. "item_image["..x..","..y..";1,1;"..minetest.formspec_escape(itemname).."]"
      result = result .. "tooltip["..name..";"..itemdesc.."]"
   end

   return result
end

function default.ui.item_group(x, y, group, name)
   local name = name or "fake_itemgroup"

   local itemname = ""

   for itemn, itemdef in pairs(minetest.registered_items) do
      if minetest.get_item_group(itemn, group) ~= 0 and minetest.get_item_group(itemn, "not_in_craftingguide") ~= 1 then
	 itemname = itemn
      end
   end

   local itemdesc = ""
   if minetest.registered_items[itemname] and minetest.registered_items[itemname].description ~= nil then
      itemdesc = minetest.registered_items[itemname].description
   end

   local result = ""
   if itemname ~= "" then
      --      result = result .. "image_button["..x..","..y..";1,1;"..itemimage..";"..name..";;false;false;"..itemimage.."]"
      result = result .. "image_button["..x..","..y..";1,1;ui_null.png;"..name..";G;false;false;ui_null.png]"
      result = result .. "item_image["..x..","..y..";1,1;"..minetest.formspec_escape(itemname).."]"
      result = result .. "tooltip["..name..";Group: "..group.."]"
   end

   return result
end

default.ui.registered_pages = {
}

function default.ui.get_page(name)
   local page= default.ui.registered_pages[name]

   if page == nil then
      default.log("UI page '" .. name .. "' is not yet registered", "dev")
      page = ""
   end

   return page
end

function default.ui.register_page(name, form)
   default.ui.registered_pages[name] = form
end

local form_default_default = ""
form_default_default = form_default_default .. "size[8.5,9]"
form_default_default = form_default_default .. default.ui.default.colors
form_default_default = form_default_default .. default.ui.default.bg
form_default_default = form_default_default .. default.ui.tab(-0.9, 0.5, "tab_crafting", "ui_icon_crafting.png", "Crafting")
if minetest.get_modpath("armor") ~= nil then
   form_default_default = form_default_default .. default.ui.tab(-0.9, 1.28, "tab_armor", "ui_icon_armor.png", "Armor")
end
if minetest.get_modpath("achievements") ~= nil then
   form_default_default = form_default_default .. default.ui.tab(-0.9, 2.06, "tab_achievements", "ui_icon_achievements.png", "Achievements")
end
if minetest.get_modpath("player_skins") ~= nil then
   form_default_default = form_default_default .. default.ui.tab(-0.9, 2.84, "tab_player_skins", "ui_icon_player_skins.png", "Player Skins")
end
form_default_default = form_default_default .. "background[0,0;8.5,9;ui_formspec_bg_tall.png]"
default.ui.register_page("default:default", form_default_default)
default.ui.register_page("default:2part", form_default_default .. "background[0,0;8.5,4.5;ui_formspec_bg_short.png]")

local form_default_notabs = ""
form_default_notabs = form_default_notabs .. "size[8.5,9]"
form_default_notabs = form_default_notabs .. default.ui.default.colors
form_default_notabs = form_default_notabs .. default.ui.default.bg
form_default_notabs = form_default_notabs .. "background[0,0;8.5,9;ui_formspec_bg_tall.png]"
default.ui.register_page("default:notabs", form_default_notabs)
default.ui.register_page("default:notabs_2part", form_default_notabs .. "background[0,0;8.5,4.5;ui_formspec_bg_short.png]")

local form_default_field = ""
form_default_field = form_default_field .. "size[8.5,5]"
form_default_field = form_default_field .. default.ui.default.colors
form_default_field = form_default_field .. default.ui.default.bg
form_default_field = form_default_field .. "background[0,0;8.5,4.5;ui_formspec_bg_short.png]"
form_default_field = form_default_field .. default.ui.button_exit(2.75, 3, 3, 1, "", "Write", false)
form_default_field = form_default_field .. "field[1,1.75;7,0;text;;${text}]"
default.ui.register_page("default:field", form_default_field)

local form_bookshelf = default.ui.get_page("default:2part")
form_bookshelf = form_bookshelf .. "list[current_player;main;0.25,4.75;8,4;]"
form_bookshelf = form_bookshelf .. "listring[current_player;main]"
form_bookshelf = form_bookshelf .. default.ui.get_hotbar_itemslot_bg(0.25, 4.75, 8, 1)
form_bookshelf = form_bookshelf .. default.ui.get_itemslot_bg(0.25, 5.75, 8, 3)

form_bookshelf = form_bookshelf .. "list[current_name;main;2.25,1.25;4,2;]"
form_bookshelf = form_bookshelf .. "listring[current_name;main]"
form_bookshelf = form_bookshelf .. default.ui.get_itemslot_bg(2.25, 1.25, 4, 2)
default.ui.register_page("default:bookshelf", form_bookshelf)

function default.ui.receive_fields(player, form_name, fields)
   local name = player:get_player_name()

   --   print("Received formspec fields from '"..name.."': "..dump(fields))

   if fields.tab_crafting then
      minetest.show_formspec(name, "crafting:crafting", crafting.get_formspec(name))
   elseif minetest.get_modpath("armor") ~= nil and fields.tab_armor then
      minetest.show_formspec(name, "armor:armor", default.ui.get_page("armor:armor"))
   elseif minetest.get_modpath("achievements") ~= nil and fields.tab_achievements then
      minetest.show_formspec(name, "achievements:achievements", achievements.get_formspec(name))
   elseif minetest.get_modpath("player_skins") ~= nil and fields.tab_player_skins then
      minetest.show_formspec(name, "player_skins:player_skins", player_skins.get_formspec(name))
   end
end

minetest.register_on_player_receive_fields(
   function(player, form_name, fields)
      default.ui.receive_fields(player, form_name, fields)
end)

minetest.register_on_joinplayer(
   function(player)
      player:set_inventory_formspec(default.ui.get_page("crafting:crafting"))
end)
