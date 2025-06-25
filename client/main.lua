-- Constants
---@class AnimationDicts
local ANIMATION_DICTS = {
    PICKUP = Config.Animations.Pickup.dict,
    PLACE = Config.Animations.Place.dict,
    CHANGE = Config.Animations.Change.dict
}

-- Cache frequently used values
local BAG_PROP_HASH = joaat(Config.Prop.Model)
local PROP_COORDS_OFFSET = vector3(0, 0, Config.Prop.Placement.ZOffset)
local FORWARD_OFFSET = Config.Prop.Placement.ForwardOffset

-- Initialize locale
if not Locale then
    Locale = {}
end
Locale.language = Config.DefaultLanguage

---@class AnimationNames
local ANIMATION_NAMES = {
    PICKUP = Config.Animations.Pickup.anim,
    PLACE = Config.Animations.Place.anim,
    CHANGE = Config.Animations.Change.anim
}

-- State
---@class State
---@field isMenuOpen boolean
---@field bagProp number|nil
---@field bagCoords vector3|nil
local state = {
    isMenuOpen = false,
    bagProp = nil,
    bagCoords = nil,
    lastInteraction = 0
}

---@class QBX
---@field PlayerData table
local QBX = {}
QBX.PlayerData = {}

-- Forward Declarations
local SpawnBagProp

-- Utility Functions
---@return string timestamp Format: YYYY-MM-DD HH:MM
local function FormatTimestamp()
    local year, month, day, hour, minute = GetLocalTime()
    return string.format('%04d-%02d-%02d %02d:%02d', year, month, day, hour, minute)
end

---@return nil
local function DeleteBagProp()
    if state.bagProp then
        exports.ox_target:removeLocalEntity(state.bagProp)
        DeleteObject(state.bagProp)
        state.bagProp = nil
        state.bagCoords = nil
    end
end

-- Animation Functions
---@return nil
local function PlayChangeAnimation()
    local ped = cache.ped
    local anim = Config.Animations.Change
    if not lib.requestAnimDict(anim.dict, 1000) then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('info.animation_failed'),
            type = 'error'
        })
        return
    end
    
    TaskPlayAnim(ped, anim.dict, anim.anim, 8.0, -8.0, -1, anim.flags, 0, false, false, false)
    Wait(anim.duration)
    ClearPedTasks(ped)
end

---@return nil
local function PlayPickupAnimation()
    local ped = cache.ped
    local anim = Config.Animations.Pickup
    
    if state.bagCoords then
        TaskTurnPedToFaceCoord(ped, state.bagCoords.x, state.bagCoords.y, state.bagCoords.z, 1500)
        Wait(1200)
    end
    
    if not lib.requestAnimDict(anim.dict, 1000) then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('info.animation_failed'),
            type = 'error'
        })
        return
    end
    
    TaskPlayAnim(ped, anim.dict, anim.anim, 1.0, 1.0, anim.duration, anim.flags, 0, false, false, false)
    Wait(anim.duration)
    
    TriggerServerEvent('qbx_outfitbag:server:addItem')
    DeleteBagProp()
    
    Wait(300)
    ClearPedTasks(ped)
end

---@return nil
local function PlaceBagOnGround()
    local ped = cache.ped
    local anim = Config.Animations.Place
    
    TriggerServerEvent('qbx_outfitbag:server:removeItem')
    
    if not lib.requestAnimDict(anim.dict, 1000) then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('info.animation_failed'),
            type = 'error'
        })
        return
    end
    
    TaskPlayAnim(ped, anim.dict, anim.anim, 8.0, -8.0, anim.duration, anim.flags, 0, false, false, false)
    Wait(anim.duration * 0.75)
    
    SpawnBagProp()
    
    Wait(300)
    ClearPedTasks(ped)
    RemoveAnimDict(anim.dict)
end

-- Prop Functions
---@return nil
SpawnBagProp = function()
    if state.bagProp then DeleteObject(state.bagProp) end
    
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    
    if not lib.requestModel(BAG_PROP_HASH, 1000) then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.prop_load_failed'),
            type = 'error'
        })
        return
    end
    
    state.bagCoords = coords + (forward * FORWARD_OFFSET) + PROP_COORDS_OFFSET
    
    state.bagProp = CreateObject(BAG_PROP_HASH, state.bagCoords.x, state.bagCoords.y, state.bagCoords.z, true, true, true)
    state.lastInteraction = GetGameTimer()
    
    if not state.bagProp then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.prop_spawn_failed'),
            type = 'error'
        })
        return
    end
    
    PlaceObjectOnGroundProperly(state.bagProp)
    SetEntityCollision(state.bagProp, Config.Prop.Placement.Collision, Config.Prop.Placement.Collision)
    FreezeEntityPosition(state.bagProp, Config.Prop.Placement.Frozen)
    
    exports.ox_target:addLocalEntity(state.bagProp, {
        {
            name = 'outfit_bag_menu',
            icon = Config.Menu.Icons.Access,
            label = Lang:t('menu.access'),
            distance = Config.Prop.Interaction.AccessDistance,
            onSelect = function()
                state.lastInteraction = GetGameTimer()
                if state.isMenuOpen then
                    lib.hideContext(false)
                    state.isMenuOpen = false
                    Wait(100)
                end
                OpenOutfitBagMenu()
            end,
            canInteract = function()
                return not lib.progressActive()
            end
        },
        {
            name = 'outfit_bag_pickup',
            icon = Config.Menu.Icons.Pickup,
            label = Lang:t('menu.pickup'),
            distance = Config.Prop.Interaction.PickupDistance,
            onSelect = function()
                state.lastInteraction = GetGameTimer()
                PlayPickupAnimation()
            end,
            canInteract = function()
                return not lib.progressActive()
            end
        }
    })
end

-- Menu Functions
---@return nil
function OpenOutfitBagMenu()
    if lib.progressActive() then return end
    
    lib.callback('qbx_outfitbag:server:getOutfits', false, function(outfits)
        local options = {
            {
                title = Lang:t('menu.save_current'),
                description = Lang:t('menu.save_description'),
                icon = Config.Menu.Icons.Save,
                iconColor = Config.Menu.Colors.Save,
                metadata = {
                    {label = Lang:t('menu.storage'), value = string.format('%d/%d', #outfits, Config.MaxOutfits)},
                    {label = Lang:t('menu.action'), value = Lang:t('menu.save_action')},
                    {label = Lang:t('menu.note'), value = Lang:t('menu.save_note')}
                },
                onSelect = function()
                    local input = lib.inputDialog(Lang:t('menu.save_title'), {
                        {
                            type = 'input',
                            label = Lang:t('menu.outfit_name'),
                            description = Lang:t('menu.outfit_name_desc'),
                            required = true,
                            placeholder = Lang:t('menu.outfit_name_placeholder')
                        },
                        {
                            type = 'input',
                            label = Lang:t('menu.outfit_desc'),
                            description = Lang:t('menu.outfit_desc_desc'),
                            placeholder = Lang:t('menu.outfit_desc_placeholder')
                        }
                    })
                    
                    if not input then return end
                    if not Config.ValidateOutfitName(input[1]) then
                        lib.notify({
                            title = Lang:t('menu.outfit_bag'),
                            description = Lang:t('error.invalid_name'),
                            type = 'error',
                            duration = Config.GetNotificationDuration('Error')
                        })
                        return
                    end
                    
                    local currentAppearance = exports['illenium-appearance']:getPedAppearance(cache.ped)
                    local outfitData = {
                        name = input[1],
                        description = input[2] or '',
                        model = GetEntityModel(cache.ped),
                        appearance = currentAppearance,
                        timestamp = FormatTimestamp()
                    }
                    
                    TriggerServerEvent('qbx_outfitbag:server:saveOutfit', outfitData)
                end
            }
        }
        
        if outfits and #outfits > 0 then
            for _, outfit in ipairs(outfits) do
                options[#options + 1] = {
                    title = outfit.outfitname,
                    description = outfit.description or Lang:t('menu.no_description'),
                    icon = Config.Menu.Icons.Load,
                    iconColor = Config.Menu.Colors.Info,
                    metadata = {
                        {label = Lang:t('menu.saved_on'), value = outfit.timestamp or Lang:t('menu.unknown_date')},
                        {label = Lang:t('menu.actions_available'), value = Lang:t('menu.actions_hint')},
                        {label = Lang:t('menu.action'), value = Lang:t('menu.load_description') .. ' / ' .. Lang:t('menu.edit_description') .. ' / ' .. Lang:t('menu.delete_description')}
                    },
                    onSelect = function()
                        lib.registerContext({
                            id = 'outfit_actions_menu',
                            title = outfit.outfitname,
                            options = {
                                {
                                    title = Lang:t('menu.load'),
                                    description = Lang:t('menu.load_description'),
                                    icon = Config.Menu.Icons.Load,
                                    iconColor = Config.Menu.Colors.Load,
                                    onSelect = function()
                                        TriggerServerEvent('qbx_outfitbag:server:loadOutfit', outfit.id)
                                    end
                                },
                                {
                                    title = Lang:t('menu.edit'),
                                    description = Lang:t('menu.edit_description'),
                                    icon = Config.Menu.Icons.Edit,
                                    iconColor = Config.Menu.Colors.Edit,
                                    onSelect = function()
                                        local input = lib.inputDialog(Lang:t('menu.edit_title'), {
                                            {
                                                type = 'input',
                                                label = Lang:t('menu.outfit_name'),
                                                description = Lang:t('menu.outfit_name_desc'),
                                                required = true,
                                                default = outfit.outfitname
                                            },
                                            {
                                                type = 'input',
                                                label = Lang:t('menu.outfit_desc'),
                                                description = Lang:t('menu.outfit_desc_desc'),
                                                default = outfit.description or ''
                                            }
                                        })
                                        
                                        if not input then return end
                                        if not Config.ValidateOutfitName(input[1]) then
                                            lib.notify({
                                                title = Lang:t('menu.outfit_bag'),
                                                description = Lang:t('error.invalid_name'),
                                                type = 'error',
                                                duration = Config.GetNotificationDuration('Error')
                                            })
                                            return
                                        end
                                        
                                        TriggerServerEvent('qbx_outfitbag:server:editOutfit', outfit.id, {
                                            name = input[1],
                                            description = input[2] or ''
                                        })
                                    end
                                },
                                {
                                    title = Lang:t('menu.delete'),
                                    description = Lang:t('menu.delete_description'),
                                    icon = Config.Menu.Icons.Delete,
                                    iconColor = Config.Menu.Colors.Delete,
                                    onSelect = function()
                                        TriggerServerEvent('qbx_outfitbag:server:deleteOutfit', outfit.id)
                                    end
                                }
                            }
                        })
                        lib.showContext('outfit_actions_menu')
                    end
                }
            end
        else
            options[#options + 1] = {
                title = Lang:t('menu.no_outfits'),
                description = Lang:t('menu.no_outfits_desc'),
                icon = Config.Menu.Icons.Info,
                iconColor = Config.Menu.Colors.Disabled,
                disabled = true
            }
        end
        
        lib.registerContext({
            id = 'outfit_bag_menu',
            title = Lang:t('menu.outfit_bag'),
            options = options,
            onClose = function()
                state.isMenuOpen = false
            end
        })
        
        state.isMenuOpen = true
        lib.showContext('outfit_bag_menu')
    end)
end

exports('useOutfitBag', function(data, slot)
    CreateThread(function()
        PlaceBagOnGround()
    end)
end)

RegisterNetEvent('qbx_outfitbag:client:useOutfitBag', function()
    CreateThread(function()
        PlaceBagOnGround()
    end)
end)

-- Event handlers for outfit operations
---@param outfitName string
---@return nil
RegisterNetEvent('qbx_outfitbag:client:outfitSaved', function(outfitName)
    lib.notify({
        title = Lang:t('menu.outfit_bag'),
        description = Lang:t('success.outfit_saved', {outfitName = outfitName}),
        type = 'success'
    })
    
    if state.isMenuOpen then
        OpenOutfitBagMenu()
    end
end)

---@param outfitName string
---@return nil
RegisterNetEvent('qbx_outfitbag:client:outfitDeleted', function(outfitName)
    lib.notify({
        title = Lang:t('menu.outfit_bag'),
        description = Lang:t('success.outfit_deleted', {outfitName = outfitName}),
        type = 'success'
    })
    
    if state.isMenuOpen then
        OpenOutfitBagMenu()
    end
end)

---@param outfitData table
---@return nil
RegisterNetEvent('qbx_outfitbag:client:loadOutfit', function(outfitData)
    lib.notify({
        title = Lang:t('menu.outfit_bag'),
        description = Lang:t('info.changing_outfit'),
        type = 'info',
        duration = 2000
    })

    if GetEntityModel(cache.ped) ~= tonumber(outfitData.model) then
        exports['illenium-appearance']:setPlayerModel(outfitData.model)
        Wait(500) -- Wait for the model to load
    end
    
    PlayChangeAnimation()
    Wait(800)
    
    exports['illenium-appearance']:setPedAppearance(cache.ped, outfitData.appearance)
    
    lib.notify({
        title = Lang:t('menu.outfit_bag'),
        description = Lang:t('success.outfit_loaded', {outfitName = outfitData.outfitname}),
        type = 'success'
    })
    
    if state.isMenuOpen then
        OpenOutfitBagMenu()
    end
end)

-- Resource cleanup
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if state.bagProp then
        DeleteBagProp()
    end
end)

-- Prop cleanup timer
CreateThread(function()
    while true do
        Wait(Config.Performance.PropCleanupInterval)
        if state.bagProp and (GetGameTimer() - state.lastInteraction) > Config.Performance.PropCleanupInterval then
            DeleteBagProp()
        end
    end
end) 