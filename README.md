# QBX Outfit Bag 👕

<div align="center">

![Stars](https://img.shields.io/github/stars/pvnqu/qbx_outfitbag?style=for-the-badge&color=blue)

</div>

A feature-rich outfit management system for QBX Framework that adds a portable outfit bag, allowing players to store and change outfits on the go. Perfect for roleplay scenarios and general gameplay enhancement.

## 🌟 Features

- 📦 Store multiple outfits in a portable bag (configurable limit)
- 💾 Save your current outfit with custom names and descriptions
- ✏️ Edit names and descriptions of saved outfits
- 👔 Quick outfit changes anywhere in the game world
- 🗑️ Easy outfit management with delete functionality
- 🎭 Smooth animations when using the bag
- 🎨 Modern UI powered by ox_lib
- 🔄 Seamless integration with illenium-appearance
- 💼 Physical bag prop placement in-game
- 🌐 Multi-language support through locale files

## 📋 Dependencies

- [QBX Core](https://github.com/Qbox-project/qbx_core)
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)
- [oxmysql](https://github.com/overextended/oxmysql)
- [illenium-appearance](https://github.com/iLLeniumStudios/illenium-appearance)

## 📥 Installation

1. Download the latest release or clone the repository
2. Place the `qbx_outfitbag` folder in your `resources/[scripts]/[qbx]` directory
3. Add to your server.cfg:
   ```cfg
   ensure qbx_outfitbag
   ```
4. Add the following item to your `items.lua` in qbx-core:
   ```lua
    ['outfit_bag'] = {
        label = 'Outfit Bag',
        weight = 100,
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
   - Delete unwanted outfits

### Controls & Commands
- Use the item from inventory to place/pickup the bag
- Target the bag with your crosshair to access its menu
- ESC to close menus

## ⚙️ Configuration

### config.lua Options
```lua
Config = {
    MaxOutfits = 5,              -- Maximum outfits per bag
    OutfitBagItem = 'outfit_bag', -- Item name for the outfit bag
    Animation = {
        dict = 'anim@heists@ornate_bank@grab_cash',
        anim = 'intro',
        flags = 51,
        duration = 1600
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
│   └── en.lua
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

### Latest Version
- Fixed UI display to show correct maximum outfits from config
- Added multi-language support
- Improved error handling
- Enhanced animation smoothness

[View full changelog](CHANGELOG.md)

---

<div align="center">
Made with ❤️ for the QBX Community
</div> 
