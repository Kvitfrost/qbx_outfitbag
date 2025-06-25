--[[ 
    QBX Outfit Bag - Configuration File
    
    This file contains all the settings you can change to customize how the outfit bag works.
    Each section is clearly explained with examples.
    
    HOW TO EDIT:
    - Numbers: Just change the number (example: 5 -> 10)
    - Text in quotes: Change the text but keep the quotes (example: 'old_text' -> 'new_text')
    - true/false: Toggle between true or false only
    - Colors: Use hex color codes (example: '#2ecc71' for green)
    - {}: Lists that can contain multiple items
]]

Config = {}

-- ════════════════════════════════════════════════════════════════════════════════
--                          BASIC SETTINGS
-- ════════════════════════════════════════════════════════════════════════════════

-- Default language for the script (available: 'en', 'es', 'fr', 'de', 'nl', 'pt', 'it', 'pl', 'ru', 'tr', 'zh')
Config.DefaultLanguage = 'en'

-- How many outfits can be stored in one bag?
Config.MaxOutfits = 5

-- What's the name of the outfit bag item in your server?
Config.OutfitBagItem = 'outfit_bag'

-- Enable this if you want to see debug messages in the console
Config.Debug = false

-- ════════════════════════════════════════════════════════════════════════════════
--                          MENU APPEARANCE
-- ════════════════════════════════════════════════════════════════════════════════

Config.Menu = {
    -- Should the menu use custom colors? If false, it will use default colors
    UseCustomColors = true,
    
    -- Menu Colors (use hex color codes, e.g., '#2ecc71' for green)
    Colors = {
        Save = '#2ecc71',   -- Color for save buttons
        Load = '#2ecc71',   -- Color for load buttons
        Edit = '#f1c40f',   -- Color for edit buttons
        Delete = '#e74c3c', -- Color for delete buttons
        Info = '#3498db',   -- Color for information text
        Disabled = '#95a5a6' -- Color for disabled options
    },
    
    -- Menu Icons (using FontAwesome icons - don't change unless you know what you're doing)
    Icons = {
        Save = 'fas fa-tshirt',      -- Icon for saving outfits
        Load = 'fas fa-user-tie',    -- Icon for loading outfits
        Edit = 'fas fa-edit',        -- Icon for editing outfits
        Delete = 'fas fa-trash',     -- Icon for deleting outfits
        Access = 'fas fa-shopping-bag', -- Icon for accessing the bag
        Pickup = 'fas fa-hand-paper'  -- Icon for picking up the bag
    }
}

-- ════════════════════════════════════════════════════════════════════════════════
--                          ANIMATIONS
-- ════════════════════════════════════════════════════════════════════════════════

Config.Animations = {
    -- Animation when changing outfits
    Change = {
        dict = 'clothingshirt',           -- Animation dictionary
        anim = 'try_shirt_positive_d',    -- Animation name
        flags = 51,                       -- Animation flags (don't change unless you know what you're doing)
        duration = 1200                   -- How long the animation plays (in milliseconds)
    },
    
    -- Animation when placing the bag on the ground
    Place = {
        dict = 'pickup_object',
        anim = 'putdown_low',
        flags = 0,
        duration = 1200
    },
    
    -- Animation when picking up the bag
    Pickup = {
        dict = 'anim@move_m@trash',
        anim = 'pickup',
        flags = 0,
        duration = 1500
    }
}

-- ════════════════════════════════════════════════════════════════════════════════
--                          BAG PROP SETTINGS
-- ════════════════════════════════════════════════════════════════════════════════

Config.Prop = {
    -- What model to use for the bag prop
    Model = 'prop_cs_heist_bag_02',
    
    -- How the bag is placed in the world
    Placement = {
        ForwardOffset = 0.8,  -- How far in front of the player to place the bag
        ZOffset = -0.9,       -- Height offset for bag placement (negative = lower)
        Collision = true,     -- Should the bag have collision?
        Frozen = true        -- Should the bag stay in place when placed?
    },
    
    -- How close players need to be to interact with the bag
    Interaction = {
        AccessDistance = 2.0,  -- How close to access the bag's menu
        PickupDistance = 2.0   -- How close to pick up the bag
    }
}

-- ════════════════════════════════════════════════════════════════════════════════
--                          NOTIFICATIONS
-- ════════════════════════════════════════════════════════════════════════════════

Config.Notifications = {
    -- Where notifications appear on the screen
    -- Options: 'top', 'top-right', 'top-left', 'center', 'center-right', 
    --          'center-left', 'bottom', 'bottom-right', 'bottom-left'
    Position = 'center-right',
    
    -- How long notifications stay on screen (in milliseconds)
    Duration = {
        Success = 3000,  -- Green notifications (success messages)
        Error = 5000,    -- Red notifications (error messages)
        Info = 2000      -- Blue notifications (information messages)
    }
}

-- ════════════════════════════════════════════════════════════════════════════════
--                          RESTRICTIONS
-- ════════════════════════════════════════════════════════════════════════════════

Config.Restrictions = {
    -- List of jobs that can use the outfit bag
    -- Leave empty {} to allow all jobs
    -- Example: {'police', 'ambulance'} to only allow police and ambulance
    AllowedJobs = {},
    
    -- List of zones where outfit changing is not allowed
    -- Leave empty {} to allow everywhere
    BlockedZones = {},
    
    -- Must players have the outfit bag in their inventory to use saved outfits?
    RequireItem = false,
    
    -- Can players have multiple outfit bags?
    AllowMultipleBags = true
}

-- ════════════════════════════════════════════════════════════════════════════════
--                          ADVANCED SETTINGS
-- ════════════════════════════════════════════════════════════════════════════════

-- These settings affect performance. Don't change unless you know what you're doing
Config.Performance = {
    -- How often to clean up abandoned props (in milliseconds)
    PropCleanupInterval = 300000,  -- 5 minutes
    
    -- How long a prop can remain without interaction before being cleaned up (in milliseconds)
    PropIdleTimeout = 600000,  -- 10 minutes
    
    -- Should outfits be cached to reduce database load?
    CacheOutfits = true,
    
    -- How long to keep outfits in cache (in milliseconds)
    CacheTimeout = 600000,  -- 10 minutes
    
    -- Maximum number of bag props that can exist at once per player
    MaxConcurrentBags = 1,
    
    -- Animation loading timeout (in milliseconds)
    AnimLoadTimeout = 1000,
    
    -- Model loading timeout (in milliseconds)
    ModelLoadTimeout = 1000,
    
    -- Distance to start rendering bag props
    RenderDistance = 50.0
}

-- ════════════════════════════════════════════════════════════════════════════════
--                          HELPER FUNCTIONS
-- ════════════════════════════════════════════════════════════════════════════════

-- Don't edit below this line unless you know what you're doing!

-- Gets animation data for a specific type
function Config.GetAnimation(type)
    return Config.Animations[type]
end

-- Checks if a player is in a blocked zone
function Config.IsInBlockedZone(coords)
    -- Add your zone checking logic here
    return false
end

-- Validates outfit names
function Config.ValidateOutfitName(name)
    if not name then return false end
    return #name >= 1 and #name <= 50
end

-- Gets notification duration based on type
function Config.GetNotificationDuration(type)
    return Config.Notifications.Duration[type] or Config.Notifications.Duration.Info
end 