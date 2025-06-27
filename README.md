# QBX Outfit Bag 👕

<div align="center">

![License](https://img.shields.io/github/license/pvnqu/qbx_outfitbag?style=for-the-badge&color=blue)
![Stars](https://img.shields.io/github/stars/pvnqu/qbx_outfitbag?style=for-the-badge&color=blue)

</div>

A feature-rich outfit management system for QBX Framework that adds a portable outfit bag, allowing players to store, change, and share outfits on the go. Perfect for roleplay scenarios and general gameplay enhancement.

## 🌟 Features

- 📦 Store multiple outfits in a portable bag (configurable limit)
- 💾 Save your current outfit with custom names and descriptions
- ✏️ Edit names and descriptions of saved outfits
- 👔 Quick outfit changes anywhere in the game world
- 🗑️ Easy outfit management with delete functionality
- 🤝 Share outfits with nearby players
- 🎭 Smooth animations when using the bag
- 🎨 Modern UI powered by ox_lib
- 🔄 Seamless integration with illenium-appearance
- 💼 Physical bag prop placement in-game
- 🌐 Comprehensive multi-language support
- 🔒 Secure ownership system
- ⚡ Optimized performance
- 🛡️ Anti-exploit measures

## 📋 Dependencies

- [QBX Core](https://github.com/Qbox-project/qbx_core)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- [oxmysql](https://github.com/overextended/oxmysql)
- [illenium-appearance](https://github.com/iLLeniumStudios/illenium-appearance)

## 📥 Installation

1. Download the latest release or clone the repository
2. Place the `qbx_outfitbag` folder in your `resources/[scripts]/[qbx]` directory
3. Add to your server.cfg:
   ```cfg
   ensure qbx_outfitbag
   ```
4. Add the following item to your `ox_inventory/data/items.lua`:
   ```lua
    ['outfit_bag'] = {
        label = 'Outfit Bag',
        weight = 1000,
        stack = false,
        close = true,
        description = 'A bag to store and change your outfits on the go',
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 2000,
            export = 'qbx_outfitbag.useOutfitBag'
        }
    },
   ```
5. The SQL table will be auto-created on first resource start

## 🌍 Supported Languages

The resource includes full translations for:
- 🇺🇸 English (en)
- 🇩🇪 German (de)
- 🇪🇸 Spanish (es)
- 🇫🇷 French (fr)
- 🇮🇹 Italian (it)
- 🇳🇱 Dutch (nl)
- 🇵🇱 Polish (pl)
- 🇵🇹 Portuguese (pt)
- 🇷🇺 Russian (ru)
- 🇹🇷 Turkish (tr)
- 🇨🇳 Chinese (zh)

## 🎮 Usage Guide

### Basic Usage
1. Obtain the `outfit_bag` item through configured methods (shops, admin, etc.)
2. Use the item from your inventory
3. Place the bag on the ground
4. Access the bag's menu to:
   - Save current outfit
   - View saved outfits
   - Change into saved outfits
   - Edit outfit names and descriptions
   - Share outfits with nearby players
   - Delete unwanted outfits

### Controls & Commands
- Use the item from inventory to place/pickup the bag
- Target the bag with your crosshair to access its menu
- ESC to close menus
- Only the owner can pick up their bag
- Bags are persistent across server restarts
- Share outfits with players within the configured distance

## ⚙️ Configuration

### config.lua Options
```lua
Config = {
    DefaultLanguage = 'en',      -- Default language for the script
    MaxOutfits = 10,            -- Maximum outfits per bag
    OutfitBagItem = 'outfit_bag', -- Item name for the outfit bag

    Menu = {
        Colors = {              -- Menu color scheme
            Save = 'success',
            Load = 'primary',
            Edit = 'warning',
            Delete = 'danger',
            Info = 'primary',
            Disabled = 'dark',
            Share = 'info'
        }
    },

    Animations = {
        Change = {             -- Outfit change animation
            dict = 'clothingshirt',
            anim = 'try_shirt_positive_d',
            flags = 16,
            duration = 3500,
            progressDuration = 3500
        },
        Place = {             -- Bag placement animation
            dict = 'anim@mp_snowball',
            anim = 'pickup_snowball',
            flags = 16,
            duration = 2000,
            progressDuration = 2000
        },
        Pickup = {           -- Bag pickup animation
            dict = 'anim@mp_snowball',
            anim = 'pickup_snowball',
            duration = 2000,
            progressDuration = 2000,
            flags = 16
        }
    },

    Prop = {
        Model = 'prop_cs_heist_bag_02',  -- Bag prop model
        Placement = {
            ForwardOffset = 0.5,         -- Distance in front of player
            ZOffset = -0.2,              -- Height offset
            Collision = true,            -- Enable collision
            Frozen = true               -- Freeze prop position
        },
        Interaction = {
            AccessDistance = 2.0,        -- Distance to access menu
            PickupDistance = 2.0,        -- Distance to pickup bag
            ShareDistance = 3.0         -- Distance to share outfits
        }
    },

    Notifications = {
        Position = 'center-right',      -- Notification position
        Duration = {
            Success = 3000,             -- Success notification duration
            Error = 5000,               -- Error notification duration
            Info = 2000                 -- Info notification duration
        }
    },

    Performance = {
        PropCleanupInterval = 300000,   -- Cleanup check interval (5 mins)
        PropIdleTimeout = 600000,       -- Prop removal timeout (10 mins)
        CacheOutfits = true,           -- Enable outfit caching
        CacheTimeout = 600000,         -- Cache timeout (10 mins)
        MaxConcurrentBags = 1,         -- Max bags per player
        AnimLoadTimeout = 1000,        -- Animation load timeout
        ModelLoadTimeout = 1000,       -- Model load timeout
        RenderDistance = 50.0          -- Prop render distance
    }
}
```

## 🔧 Development

### File Structure
```
qbx_outfitbag/
├── client/
│   └── main.lua
├── server/
│   └── main.lua
├── locales/
│   ├── de.lua
│   ├── en.lua
│   ├── es.lua
│   ├── fr.lua
│   ├── it.lua
│   ├── nl.lua
│   ├── pl.lua
│   ├── pt.lua
│   ├── ru.lua
│   ├── tr.lua
│   └── zh.lua
├── config.lua
└── fxmanifest.lua
```

### Adding New Features?
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 🐛 Bug Reports & Feature Requests

Found a bug or have a feature request? Please use the GitHub issues system:
1. Check if your issue has already been reported
2. Include detailed steps to reproduce bugs
3. Include screenshots if helpful
4. Include your server version and relevant configuration

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are always welcome! Please read our contributing guidelines before submitting pull requests.

## ❤️ Support

If you find this resource helpful, please consider:
- Starring the repository
- Sharing it with others
- Contributing to its development

## 🔄 Changelog

### Latest Version (1.0.0)
- Added outfit sharing functionality with nearby players
- Added comprehensive language support for 11 languages
- Improved bag ownership system with better security
- Enhanced animation system with better error handling
- Added detailed configuration options
- Added anti-exploit measures
- Added persistent bag placement
- Added outfit description support
- Added edit functionality for saved outfits
- Optimized performance and reduced resource usage
- Fixed various bugs and improved stability

[View full changelog](CHANGELOG.md)

---

<div align="center">
Made with ❤️ for the QBX Community
</div> 
