
--
-- Recipes
--

-- Autogenerated tools

local tool_types = {
   pick = {
      wood = "group:planks 3",
      stone = "group:stone 3",
      wrought_iron = "default:ingot_wrought_iron 3",
      steel = "default:ingot_steel 3",
      carbon_steel = "default:ingot_carbon_steel 3",
      bronze = "default:ingot_bronze 3",
   },
   shovel = {
      wood = "group:planks 3",
      stone = "group:stone 3",
      wrought_iron = "default:ingot_wrought_iron 3",
      steel = "default:ingot_steel 3",
      carbon_steel = "default:ingot_carbon_steel 3",
      bronze = "default:ingot_bronze 3",
   },
   axe= {
      wood = "group:planks 3",
      stone = "group:stone 3",
      wrought_iron = "default:ingot_wrought_iron 3",
      steel = "default:ingot_steel 3",
      carbon_steel = "default:ingot_carbon_steel 3",
      bronze = "default:ingot_bronze 3",
   },
   spear = {
      wood = "group:planks 2",
      stone = "group:stone 2",
      wrought_iron = "default:ingot_wrought_iron 2",
      steel = "default:ingot_steel 2",
      carbon_steel = "default:ingot_carbon_steel 2",
      bronze = "default:ingot_bronze 2",
   },
}

for tool_name, tool_type in pairs(tool_types) do
   for material_name, material_item in pairs(tool_type) do
      crafting.register_craft(
         {
            output = "default:" .. tool_name .. "_" .. material_name,
            items = {
               material_item,
               "default:fiber 4",
               "default:stick 3",
            }
      })
   end
end

-- Broadsword

crafting.register_craft(
   {
      output = "default:broadsword",
      items = {
         "default:ingot_steel 4",
         "default:fiber 5",
         "default:stick 2",
      }
})

-- Shears

crafting.register_craft(
   {
      output = "default:shears",
      items = {
         "default:ingot_wrought_iron 2",
         "default:fiber 2",
         "default:stick 2",
      }
})

-- Minerals

crafting.register_craft(
   {
      output = "default:ingot_steel 2",
      items = {
         "default:sheet_graphite",
         "default:ingot_wrought_iron 4",
      }
})

crafting.register_craft(
   {
      output = "default:ingot_carbon_steel 2",
      items = {
         "default:sheet_graphite 2",
         "default:ingot_wrought_iron 7",
      }
})

crafting.register_craft(
   {
      output = "default:lump_bronze 2",
      items = {
         "default:lump_tin 2",
         "default:lump_copper 5",
      }
})

-- Items

crafting.register_craft(
   {
      output = "default:rope 2",
      items = {
         "default:dry_grass 3",
      }
})

crafting.register_craft(
   {
      output = "default:fiber 3",
      items = {
         "default:leaves 4",
      }
})

crafting.register_craft(
   {
      output = "default:fiber",
      items = {
         "default:grass",
      }
})

crafting.register_craft(
   {
      output = "default:stick 4",
      items = {
         "group:planks",
      }
})

crafting.register_craft(
   {
      output = "default:flint 2",
      items = {
         "default:gravel",
      }
})

crafting.register_craft(
   {
      output = "default:paper",
      items = {
         "default:papyrus 3",
      }
})

crafting.register_craft(
   {
      output = "default:book",
      items = {
         "default:paper 3",
         "default:stick",
         "default:fiber",
      }
})

crafting.register_craft(
   {
      output = "default:flint_and_steel",
      items = {
         "default:ingot_steel",
         "default:fiber",
         "default:flint",
      }
})

crafting.register_craft(
   {
      output = "default:bucket",
      items = {
         "default:stick 2",
         "default:fiber 4",
         "group:planks 5",
      }
})

-- Stone nodes

crafting.register_craft(
   {
      output = "default:gravel",
      items = {
         "default:cobble",
      }
})

crafting.register_craft(
   {
      output = "default:brick 2",
      items = {
         "group:soil 5",
         "default:gravel 4",
      }
})

-- Block nodes

crafting.register_craft(
   {
      output = "default:block_wrought_iron",
      items = {
         "default:ingot_wrought_iron 9",
      }
})

crafting.register_craft(
   {
      output = "default:block_steel",
      items = {
         "default:ingot_steel 9",
      }
})

crafting.register_craft(
   {
      output = "default:block_carbon_steel",
      items = {
         "default:ingot_carbon_steel 9",
      }
})

crafting.register_craft(
   {
      output = "default:block_bronze",
      items = {
         "default:ingot_bronze 9",
      }
})

crafting.register_craft(
   {
      output = "default:block_coal",
      items = {
         "default:lump_coal 9",
      }
})

-- Path nodes

crafting.register_craft(
   {
      output = "default:dirt_path 8",
      items = {
         "group:soil 3",
         "default:gravel 6",
      }
})

crafting.register_craft(
   {
      output = "default:path_slab",
      items = {
         "default:dirt_path",
      }
})

crafting.register_craft(
   {
      output = "default:heated_dirt_path",
      items = {
         "default:dirt_path",
         "default:ingot_wrought_iron",
      }
})

-- Wood nodes

crafting.register_craft(
   {
      output = "default:planks 4",
      items = {
         "default:tree",
      }
})

crafting.register_craft(
   {
      output = "default:planks_oak 4",
      items = {
         "default:tree_oak",
      }
})

crafting.register_craft(
   {
      output = "default:planks_birch 4",
      items = {
         "default:tree_birch",
      }
})

-- Frame nodes

crafting.register_craft(
   {
      output = "default:frame",
      items = {
         "default:fiber 8",
         "default:stick 6",
         "group:planks",
      }
})

crafting.register_craft(
   {
      output = "default:reinforced_frame",
      items = {
         "default:fiber 8",
         "default:stick 6",
         "default:frame",
      }
})

crafting.register_craft(
   {
      output = "default:reinforced_cobble",
      items = {
         "default:fiber 8",
         "default:stick 6",
         "default:cobble",
      }
})

-- Fence nodes

crafting.register_craft(
   {
      output = "default:fence 4",
      items = {
         "default:planks",
         "default:fiber 4",
         "default:stick 4",
      }
})

crafting.register_craft(
   {
      output = "default:fence_oak 4",
      items = {
         "default:planks_oak",
         "default:stick 4",
         "default:fiber 4",
      }
})

crafting.register_craft(
   {
      output = "default:fence_birch 4",
      items = {
         "default:planks_birch",
         "default:stick 4",
         "default:fiber 4",
      }
})

-- Misc nodes

crafting.register_craft(
   {
      output = "default:sign 2",
      items = {
         "group:planks",
         "default:fiber 2",
         "default:stick 2",
      }
})

crafting.register_craft(
   {
      output = "default:torch 2",
      items = {
         "default:lump_coal",
         "default:stick",
         "default:fiber",
      }
})

crafting.register_craft(
   {
      output = "default:torch_weak 2",
      items = {
         "default:stick",
         "default:fiber",
      }
})

crafting.register_craft(
   {
      output = "default:ladder 2",
      items = {
         "default:stick 5",
         "default:fiber 2",
      }
})

-- Tool nodes (chests, furnaces, bookshelves)

crafting.register_craft(
   {
      output = "default:chest",
      items = {
         "default:stick 12",
         "default:fiber 8",
         "group:planks 6",
      }
})

crafting.register_craft(
   {
      output = "default:furnace",
      items = {
         "default:torch",
         "group:stone 6",
      }
})

crafting.register_craft(
   {
      output = "default:bookshelf",
      items = {
         "default:book 3",
         "group:planks 6",
      }
})

-- Sand nodes

crafting.register_craft(
   {
      output = "default:sandstone",
      items = {
         "default:sand 2",
      }
})

crafting.register_craft(
   {
      output = "default:compressed_sandstone",
      items = {
         "default:sandstone 2",
      }
})

-- Agriculture nodes

crafting.register_craft(
   {
      output = "default:fertilizer",
      items = {
         "default:fern 4",
         "default:fiber 3",
      }
})

crafting.register_craft(
   {
      output = "default:fertilizer 2",
      items = {
         "default:lump_sulfur 3",
         "default:fiber 3",
      }
})

default.log("recipes", "loaded")
