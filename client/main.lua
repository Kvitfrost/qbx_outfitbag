-- Constants
local ANIMATIONS = {
    PICKUP = {
        dict = Config.Animations.Pickup.dict,
        anim = Config.Animations.Pickup.anim,
        duration = Config.Animations.Pickup.duration,
        progressDuration = Config.Animations.Pickup.progressDuration,
        flags = Config.Animations.Pickup.flags
    },
    PLACE = {
        dict = Config.Animations.Place.dict,
        anim = Config.Animations.Place.anim,
        duration = Config.Animations.Place.duration,
        progressDuration = Config.Animations.Place.progressDuration,
        flags = Config.Animations.Place.flags
    },
    CHANGE = {
        dict = Config.Animations.Change.dict,
        anim = Config.Animations.Change.anim,
        duration = Config.Animations.Change.duration,
        progressDuration = Config.Animations.Change.progressDuration,
        flags = Config.Animations.Change.flags
    }
}

local BAG_PROP_HASH = joaat(Config.Prop.Model)
local PROP_COORDS_OFFSET = vector3(0, 0, Config.Prop.Placement.ZOffset)
local FORWARD_OFFSET = Config.Prop.Placement.ForwardOffset
local GetEntityCoords = GetEntityCoords
local GetEntityForwardVector = GetEntityForwardVector
local GetGameTimer = GetGameTimer
local DoesEntityExist = DoesEntityExist
local CreateObject = CreateObject
local DeleteObject = DeleteObject
local TaskPlayAnim = TaskPlayAnim
local Wait = Wait
local TriggerServerEvent = TriggerServerEvent
local GetEntityModel = GetEntityModel
local SetEntityCollision = SetEntityCollision
local FreezeEntityPosition = FreezeEntityPosition
local PlaceObjectOnGroundProperly = PlaceObjectOnGroundProperly

local state = setmetatable({
    isMenuOpen = false,
    bagProp = nil,
    bagCoords = nil,
    lastInteraction = 0,
    ownedBags = {}
}, {
    __index = function(t, k)
        if k == 'ownedBags' then
            t[k] = {}
            return t[k]
        end
    end
})

---@return string timestamp Format: YYYY-MM-DD HH:MM
local function FormatTimestamp()
    local year, month, day, hour, minute = GetLocalTime()
    return ('%04d-%02d-%02d %02d:%02d'):format(year, month, day, hour, minute)
end

---@return nil
DeleteBagProp = function()
    if state.bagProp and DoesEntityExist(state.bagProp) then
        state.ownedBags[state.bagProp] = nil
        DeleteObject(state.bagProp)
        state.bagProp = nil
        state.bagCoords = nil
    end
end

---@return table|nil nearbyPlayers List of nearby players with their server IDs and distances
local function GetNearbyPlayers()
    local playerPed = cache.ped
    local playerCoords = GetEntityCoords(playerPed)
    local maxDistance = Config.Prop.Interaction.ShareDistance
    local nearbyPlayers = {}
    local players = GetActivePlayers()
    local playersCount = #players
    
    for i = 1, playersCount do
        local player = players[i]
        local targetPed = GetPlayerPed(player)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(playerCoords - targetCoords)
            if distance <= maxDistance then
                nearbyPlayers[#nearbyPlayers + 1] = {
                    id = GetPlayerServerId(player),
                    distance = math.floor(distance)
                }
            end
        end
    end
    
    return #nearbyPlayers > 0 and nearbyPlayers or nil
end

---@return nil
PlayAnimation = function(animType)
    local ped = cache.ped
    local anim = ANIMATIONS[animType]
    if not anim then return false end
    
    if animType == 'PLACE' and state.bagCoords then
        TaskTurnPedToFaceCoord(ped, state.bagCoords.x, state.bagCoords.y, state.bagCoords.z, 1500)
        Wait(1200)
    end
    
    if not lib.requestAnimDict(anim.dict, 1000) then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('info.animation_failed'),
            type = 'error'
        })
        return false
    end
    
    local progressConfig = {
        duration = anim.progressDuration,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false
        }
    }

    if animType == 'CHANGE' then
        progressConfig.label = Lang:t('info.changing_outfit')
    elseif animType == 'PLACE' then
        progressConfig.label = Lang:t('info.placing_bag')
    elseif animType == 'PICKUP' then
        progressConfig.label = Lang:t('info.picking_up_bag')
    end

    TaskPlayAnim(ped, anim.dict, anim.anim, 8.0, -8.0, anim.duration, anim.flags, 0, false, false, false)
    local success = lib.progressBar(progressConfig)
    
    if not success then
        ClearPedTasks(ped)
        RemoveAnimDict(anim.dict)
        return false
    end
    
    ClearPedTasks(ped)
    RemoveAnimDict(anim.dict)
    return true
end

CreateThread(function()
    state.ownedBags = state.ownedBags or {}
    Wait(1000)
    
    exports.ox_target:addModel(BAG_PROP_HASH, {
        {
            name = 'outfit_bag_menu_shared',
            icon = Config.Menu.Icons.Access,
            label = Lang:t('menu.access'),
            distance = Config.Prop.Interaction.AccessDistance,
            onSelect = function()
                if state.isMenuOpen then
                    lib.hideContext(false)
                    state.isMenuOpen = false
                    Wait(100)
                end
                OpenOutfitBagMenu()
            end,
            canInteract = function(data)
                local entity = type(data) == 'table' and data.entity or data
                if not entity then return false end
                if not DoesEntityExist(entity) then return false end
                if lib.progressActive() then return false end
                return state.ownedBags[entity]
            end
        },
        {
            name = 'outfit_bag_pickup_owner',
            icon = Config.Menu.Icons.Pickup,
            label = Lang:t('menu.pickup'),
            distance = Config.Prop.Interaction.PickupDistance,
            onSelect = function(data)
                local entity = type(data) == 'table' and data.entity or data
                if entity and DoesEntityExist(entity) then
                    HandleBagPickup(entity)
                end
            end,
            canInteract = function(data)
                local entity = type(data) == 'table' and data.entity or data
                if not entity then return false end
                if not DoesEntityExist(entity) then return false end
                if GetEntityModel(entity) ~= BAG_PROP_HASH then return false end
                return not lib.progressActive() and state.ownedBags[entity]
            end
        }
    })
    
    local interval = Config.Performance.PropCleanupInterval
    while true do
        Wait(interval)
        local currentTime = GetGameTimer()
        if state.bagProp and DoesEntityExist(state.bagProp) and (currentTime - state.lastInteraction) > interval then
            DeleteBagProp()
            TriggerServerEvent('qbx_outfitbag:server:addItem')
        end
    end
end)

---@return nil
SpawnBagProp = function()
    local hasItem = lib.callback.await('qbx_outfitbag:server:hasItem', false)
    if not hasItem then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.no_bag'),
            type = 'error'
        })
        return
    end

    TriggerServerEvent('qbx_outfitbag:server:removeItem')
    
    DeleteBagProp()
    
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local forward = GetEntityForwardVector(ped)
    
    if not lib.requestModel(BAG_PROP_HASH, 1000) then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.prop_load_failed'),
            type = 'error'
        })
        TriggerServerEvent('qbx_outfitbag:server:addItem')
        return
    end
    
    if not PlayAnimation('PLACE') then
        TriggerServerEvent('qbx_outfitbag:server:addItem')
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
        TriggerServerEvent('qbx_outfitbag:server:addItem')
        return
    end
    
    state.ownedBags[state.bagProp] = true
    local netId = NetworkGetNetworkIdFromEntity(state.bagProp)
    TriggerServerEvent('qbx_outfitbag:server:syncBagOwnership', netId)
    
    PlaceObjectOnGroundProperly(state.bagProp)
    SetEntityCollision(state.bagProp, Config.Prop.Placement.Collision, Config.Prop.Placement.Collision)
    FreezeEntityPosition(state.bagProp, Config.Prop.Placement.Frozen)
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
                                    title = Lang:t('menu.share'),
                                    description = Lang:t('menu.share_description'),
                                    icon = Config.Menu.Icons.Share,
                                    iconColor = Config.Menu.Colors.Share,
                                    onSelect = function()
                                        local nearbyPlayers = GetNearbyPlayers()
                                        if not nearbyPlayers then
                                            lib.notify({
                                                title = Lang:t('menu.outfit_bag'),
                                                description = Lang:t('error.no_players_nearby'),
                                                type = 'error'
                                            })
                                            return
                                        end

                                        local playerList = {}
                                        for _, player in ipairs(nearbyPlayers) do
                                            playerList[#playerList + 1] = {
                                                title = Lang:t('menu.player_id', { playerId = player.id }),
                                                description = Lang:t('menu.player_distance', { distance = player.distance }),
                                                onSelect = function()
                                                    TriggerServerEvent('qbx_outfitbag:server:shareOutfit', outfit.id, player.id)
                                                end
                                            }
                                        end

                                        lib.registerContext({
                                            id = 'share_outfit_menu',
                                            title = Lang:t('menu.share_with'),
                                            menu = 'outfit_actions_menu',
                                            options = playerList
                                        })

                                        lib.showContext('share_outfit_menu')
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

exports('useOutfitBag', function()
    CreateThread(function()
        SpawnBagProp()
    end)
end)

RegisterNetEvent('qbx_outfitbag:client:useOutfitBag', function()
    CreateThread(function()
        SpawnBagProp()
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
        Wait(500)
    end
    
    PlayAnimation('CHANGE')
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

HandleBagPickup = function(entityHit)
    if not entityHit or not DoesEntityExist(entityHit) then return end
    
    if not state.ownedBags[entityHit] then
        lib.notify({
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.not_your_bag'),
            type = 'error'
        })
        return
    end
    
    if PlayAnimation('PICKUP') then
        local netId = NetworkGetNetworkIdFromEntity(entityHit)
        TriggerServerEvent('qbx_outfitbag:server:removeBagOwnership', netId)
        
        DeleteObject(entityHit)
        state.ownedBags[entityHit] = nil
        
        TriggerServerEvent('qbx_outfitbag:server:addItem')
        
        if state.bagProp == entityHit then
            state.bagProp = nil
            state.bagCoords = nil
        end
    end
end

RegisterNetEvent('qbx_outfitbag:client:syncBagOwnership', function(netId, ownerServerId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if entity and DoesEntityExist(entity) then
        if ownerServerId == cache.serverId then
            state.ownedBags[entity] = true
        end
    end
end)

RegisterNetEvent('qbx_outfitbag:client:removeBagOwnership', function(netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    if entity and DoesEntityExist(entity) then
        state.ownedBags[entity] = nil
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    DeleteBagProp()
end) 