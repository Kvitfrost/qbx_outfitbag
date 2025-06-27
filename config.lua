Config = {}

Config.DefaultLanguage = 'en'
Config.MaxOutfits = 10
Config.OutfitBagItem = 'outfit_bag'

Config.Menu = {
    Colors = {
        Save = 'success',
        Load = 'primary',
        Edit = 'warning',
        Delete = 'danger',
        Info = 'primary',
        Disabled = 'dark',
        Share = 'info'
    },
    
    Icons = {
        Save = 'fas fa-save',
        Load = 'fas fa-tshirt',
        Edit = 'fas fa-edit',
        Delete = 'fas fa-trash',
        Access = 'fas fa-suitcase',
        Pickup = 'fas fa-hand-paper',
        Share = 'fas fa-share',
        Info = 'fas fa-info-circle'
    }
}

Config.Animations = {
    Change = {
        dict = 'clothingshirt',
        anim = 'try_shirt_positive_d',
        flags = 16,
        duration = 3500,
        progressDuration = 3500
    },
    
    Place = {
        dict = 'anim@mp_snowball',
        anim = 'pickup_snowball',
        flags = 16,
        duration = 2000,
        progressDuration = 2000
    },
    
    Pickup = {
        dict = 'anim@mp_snowball',
        anim = 'pickup_snowball',
        duration = 2000,
        progressDuration = 2000,
        flags = 16
    }
}

Config.Prop = {
    Model = 'prop_cs_heist_bag_02',
    
    Placement = {
        ForwardOffset = 0.5,
        ZOffset = -0.2,
        Collision = true,
        Frozen = true
    },
    
    Interaction = {
        AccessDistance = 2.0,
        PickupDistance = 2.0,
        ShareDistance = 3.0
    }
}

Config.Notifications = {
    Position = 'center-right',
    
    Duration = {
        Success = 3000,
        Error = 5000,
        Info = 2000
    }
}

Config.Restrictions = {
    AllowedJobs = {},
    BlockedZones = {},
    RequireItem = false,
    AllowMultipleBags = true
}

Config.Performance = {
    PropCleanupInterval = 300000,
    PropIdleTimeout = 600000,
    CacheOutfits = true,
    CacheTimeout = 600000,
    MaxConcurrentBags = 1,
    AnimLoadTimeout = 1000,
    ModelLoadTimeout = 1000,
    RenderDistance = 50.0
}

---@param name string The outfit name to validate
---@return boolean isValid Whether the outfit name is valid
function Config.ValidateOutfitName(name)
    if not name then return false end
    if #name < 1 or #name > 30 then return false end
    return not string.match(name, '[^%w%s%-_]')
end