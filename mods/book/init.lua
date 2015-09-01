--
-- Editable books
-- Code based off the books_plus mod
-- By Kaadmy, for Pixture
--

minetest.register_craftitem(
   ":default:book",
   {
      description = "Book",
      inventory_image = "default_book.png",
      stack_max = 1,
      on_use = function(itemstack, player, pointed_thing)
		  local name = player:get_player_name()
		  local data = minetest.deserialize(itemstack:get_metadata())

		  local title = ""
		  local text = ""

		  if data then
		     text = data.text
		     title = data.title
		  end

		  local form = default.ui.get_page("core_notabs")
		  form = form .. "field[0.5,1.25;8,0;title;Title:;"..minetest.formspec_escape(title).."]"
		  form = form .. "textarea[0.5,1.75;8,6.75;text;Contents:;"..minetest.formspec_escape(text).."]"
		  form = form .. default.ui.button_exit(2.75, 7.75, 3, 1, "write", "Write")

		  minetest.show_formspec(name, "book:book", form)
	       end,
   })

minetest.register_on_player_receive_fields(
   function(player, form_name, fields)
      if form_name ~= "book:book" or not fields.write then return end

      local itemstack = player:get_wielded_item()
      local data = minetest.deserialize(itemstack:get_metadata())

      if not data then data = {} end
      data.text = fields.text
      data.title = fields.title
      
      itemstack:set_metadata(minetest.serialize(data))
      player:set_wielded_item(itemstack)
   end)