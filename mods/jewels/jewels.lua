--
-- Jeweled tool defs
--

--  Automatic jeweling on specific tools

local tool_types = {
   pick = {
      steel = {
         digspeed = {
            digspeed = -0.1,
         },
         damage = {
            fleshy = 1,
         },
         uses = {
            uses = 3,
         },
      },
      carbon_steel = {
         digspeed = {
            digspeed = -0.13,
         },
         damage = {
            fleshy = 2,
         },
         uses = {
            uses = 5,
         },
      },
      bronze = {
         digspeed = {
            digspeed = -0.14,
         },
         damage = {
            fleshy = 3,
         },
         uses = {
            uses = 6,
         },
      },
   },
   shovel = {
      steel = {
         digspeed = {
            digspeed = -0.1,
         },
         damage = {
            fleshy = 1,
         },
         uses = {
            uses = 3,
         },
      },
      carbon_steel = {
         digspeed = {
            digspeed = -0.13,
         },
         damage = {
            fleshy = 2,
         },
         uses = {
            uses = 5,
         },
      },
      bronze = {
         digspeed = {
            digspeed = -0.14,
         },
         damage = {
            fleshy = 3,
         },
         uses = {
            uses = 6,
         },
      },
   },
   axe = {
      steel = {
         digspeed = {
            digspeed = -0.1,
         },
         damage = {
            fleshy = 2,
         },
         uses = {
            uses = 3,
         },
      },
      carbon_steel = {
         digspeed = {
            digspeed = -0.13,
         },
         damage = {
            fleshy = 3,
         },
         uses = {
            uses = 5,
         },
      },
      bronze = {
         digspeed = {
            digspeed = -0.14,
         },
         damage = {
            fleshy = 4,
         },
         uses = {
            uses = 6,
         },
      },
   },
   spear = {
      steel = {
         reach = {
            reach = 1,
         },
         damage = {
            fleshy = 3,
         },
         uses = {
            uses = 3,
         },
      },
      carbon_steel = {
         reach = {
            reach = 2,
         },
         damage = {
            fleshy = 4,
         },
         uses = {
            uses = 5,
         },
      },
      bronze = {
         reach = {
            reach = 2,
         },
         damage = {
            fleshy = 5,
         },
         uses = {
            uses = 6,
         },
      },
   },
}

for tool_name, tool_def in pairs(tool_types) do
   for material_name, material_def in pairs(tool_def) do
      for jewel_name, jewel_def in pairs(material_def) do
         jewels.register_jewel(
            "default:" .. tool_name .. "_" .. material_name,
            "jewels:" .. tool_name .. "_" .. material_name .. "_" .. jewel_name,
            {
               stats = jewel_def,
         })
      end
   end
end

-- Broadswords

jewels.register_jewel(
   "default:broadsword",
   "jewels:broadsword_jeweled_pommel",
   {
      description = "Jeweled Pommel Broadsword",
      overlay = "jewels_jeweled_pommel.png",
      stats = {
	 fleshy = 2,
      }
})

jewels.register_jewel(
   "jewels:broadsword_jeweled_pommel",
   "jewels:broadsword_jeweled_pommel_and_guard",
   {
      description = "Jeweled Pommel&Guard Broadsword",
      overlay = "jewels_jeweled_guard.png",
      stats = {
	 range = 1,
      }
})

jewels.register_jewel(
   "jewels:broadsword_jeweled_pommel_and_guard",
   "jewels:serrated_broadsword",
   {
      description = "Serrated Broadsword",
      overlay = "jewels_jeweled_blade.png",
      stats = {
	 fleshy = 2,
	 range = 1,
      }
})

default.log("jewels", "loaded")
