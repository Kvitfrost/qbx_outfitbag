local QBX = exports.qbx_core

local function InitializeDatabase()
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS outfit_bags (
            id INT AUTO_INCREMENT PRIMARY KEY,
            citizenid VARCHAR(50) NOT NULL,
            outfitname VARCHAR(50) NOT NULL,
            description TEXT,
            timestamp VARCHAR(50),
            model VARCHAR(50) NOT NULL,
            appearance LONGTEXT NOT NULL,
            INDEX idx_citizenid (citizenid)
        )
    ]])
    
    MySQL.query([[
        ALTER TABLE outfit_bags
        ADD COLUMN IF NOT EXISTS description TEXT,
        ADD COLUMN IF NOT EXISTS timestamp VARCHAR(50),
        ADD INDEX IF NOT EXISTS idx_citizenid (citizenid)
    ]])
end

MySQL.ready(InitializeDatabase)

local function ValidatePlayer(src)
    local Player = QBX:GetPlayer(src)
    if not Player then return nil end
    return Player
end

local function HasOutfitBag(src)
    local hasItem = exports.ox_inventory:GetItem(src, Config.OutfitBagItem, nil, true)
    if not hasItem then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.no_outfit_bag'),
            type = 'error'
        })
        return false
    end
    return true
end

lib.callback.register('qbx_outfitbag:server:getOutfits', function(source)
    local Player = ValidatePlayer(source)
    if not Player then return end

    local result = MySQL.query.await('SELECT * FROM outfit_bags WHERE citizenid = ?', {
        Player.PlayerData.citizenid
    })

    if result then
        for i = 1, #result do
            result[i].appearance = json.decode(result[i].appearance)
        end
    end

    return result
end)

RegisterNetEvent('qbx_outfitbag:server:saveOutfit', function(outfitData)
    local src = source
    local Player = ValidatePlayer(src)
    if not Player then return end
    
    if not HasOutfitBag(src) then return end

    local currentOutfits = MySQL.query.await('SELECT COUNT(*) as count FROM outfit_bags WHERE citizenid = ?', {
        Player.PlayerData.citizenid
    })

    if currentOutfits[1].count >= Config.MaxOutfits then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('info.bag_full', { maxOutfits = Config.MaxOutfits }),
            type = 'error'
        })
        return
    end

    local success = MySQL.insert.await('INSERT INTO outfit_bags (citizenid, outfitname, description, timestamp, model, appearance) VALUES (?, ?, ?, ?, ?, ?)', {
        Player.PlayerData.citizenid,
        outfitData.name,
        outfitData.description,
        outfitData.timestamp,
        outfitData.model,
        json.encode(outfitData.appearance)
    })

    if not success then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.failed_to_save'),
            type = 'error'
        })
        return
    end

    TriggerClientEvent('qbx_outfitbag:client:outfitSaved', src, outfitData.name)
end)

RegisterNetEvent('qbx_outfitbag:server:loadOutfit', function(outfitId)
    local src = source
    local Player = ValidatePlayer(src)
    if not Player then return end
    
    if not HasOutfitBag(src) then return end

    local result = MySQL.single.await('SELECT * FROM outfit_bags WHERE id = ? AND citizenid = ?', {
        outfitId,
        Player.PlayerData.citizenid
    })

    if not result then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.outfit_not_found'),
            type = 'error'
        })
        return
    end

    result.appearance = json.decode(result.appearance)
    if not result.appearance then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.failed_to_load'),
            type = 'error'
        })
        return
    end

    TriggerClientEvent('qbx_outfitbag:client:loadOutfit', src, result)
end)

RegisterNetEvent('qbx_outfitbag:server:deleteOutfit', function(outfitId)
    local src = source
    local Player = ValidatePlayer(src)
    if not Player then return end
    
    if not HasOutfitBag(src) then return end

    local result = MySQL.single.await('SELECT outfitname FROM outfit_bags WHERE id = ? AND citizenid = ?', {
        outfitId,
        Player.PlayerData.citizenid
    })

    if not result then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.outfit_not_found'),
            type = 'error'
        })
        return
    end

    local success = MySQL.query.await('DELETE FROM outfit_bags WHERE id = ? AND citizenid = ?', {
        outfitId,
        Player.PlayerData.citizenid
    })

    if not success then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.failed_to_delete'),
            type = 'error'
        })
        return
    end

    TriggerClientEvent('qbx_outfitbag:client:outfitDeleted', src, result.outfitname)
end)

RegisterNetEvent('qbx_outfitbag:server:editOutfit', function(outfitId, outfitData)
    local src = source
    local Player = ValidatePlayer(src)
    if not Player then return end
    
    if not HasOutfitBag(src) then return end

    local result = MySQL.single.await('SELECT outfitname FROM outfit_bags WHERE id = ? AND citizenid = ?', {
        outfitId,
        Player.PlayerData.citizenid
    })

    if not result then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.outfit_not_found'),
            type = 'error'
        })
        return
    end

    local success = MySQL.query.await('UPDATE outfit_bags SET outfitname = ?, description = ? WHERE id = ? AND citizenid = ?', {
        outfitData.name,
        outfitData.description,
        outfitId,
        Player.PlayerData.citizenid
    })

    if not success then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.failed_to_edit'),
            type = 'error'
        })
        return
    end

    lib.notify(src, {
        title = Lang:t('menu.outfit_bag'),
        description = Lang:t('success.outfit_edited', { outfitName = outfitData.name }),
        type = 'success'
    })

    TriggerClientEvent('qbx_outfitbag:client:outfitSaved', src)
end)

RegisterNetEvent('qbx_outfitbag:server:removeItem', function()
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return end
    
    Player.Functions.RemoveItem(Config.OutfitBagItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, exports.ox_inventory:Items()[Config.OutfitBagItem], 'remove')
end)

RegisterNetEvent('qbx_outfitbag:server:addItem', function()
    local src = source
    local Player = exports.qbx_core:GetPlayer(src)
    if not Player then return end
    
    Player.Functions.AddItem(Config.OutfitBagItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, exports.ox_inventory:Items()[Config.OutfitBagItem], 'add')
end)

RegisterNetEvent('qbx_outfitbag:server:shareOutfit', function(outfitId, targetId)
    local src = source
    local Player = ValidatePlayer(src)
    if not Player then return end
    
    if not HasOutfitBag(src) then return end

    local result = MySQL.single.await('SELECT * FROM outfit_bags WHERE id = ? AND citizenid = ?', {
        outfitId,
        Player.PlayerData.citizenid
    })

    if not result then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.outfit_not_found'),
            type = 'error'
        })
        return
    end

    local TargetPlayer = ValidatePlayer(targetId)
    if not TargetPlayer then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.target_not_found'),
            type = 'error'
        })
        return
    end

    if not HasOutfitBag(targetId) then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.target_no_outfit_bag'),
            type = 'error'
        })
        return
    end

    local currentOutfits = MySQL.query.await('SELECT COUNT(*) as count FROM outfit_bags WHERE citizenid = ?', {
        TargetPlayer.PlayerData.citizenid
    })

    if currentOutfits[1].count >= Config.MaxOutfits then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.target_bag_full'),
            type = 'error'
        })
        return
    end

    local success = MySQL.insert.await('INSERT INTO outfit_bags (citizenid, outfitname, description, timestamp, model, appearance) VALUES (?, ?, ?, ?, ?, ?)', {
        TargetPlayer.PlayerData.citizenid,
        result.outfitname .. ' (Shared)',
        result.description,
        os.date('%Y-%m-%d %H:%M'),
        result.model,
        result.appearance
    })

    if not success then
        lib.notify(src, {
            title = Lang:t('menu.outfit_bag'),
            description = Lang:t('error.failed_to_share'),
            type = 'error'
        })
        return
    end

    lib.notify(src, {
        title = Lang:t('menu.outfit_bag'),
        description = Lang:t('success.outfit_shared_sender', { outfitName = result.outfitname }),
        type = 'success'
    })

    lib.notify(targetId, {
        title = Lang:t('menu.outfit_bag'),
        description = Lang:t('success.outfit_shared_receiver', { outfitName = result.outfitname }),
        type = 'success'
    })
end)

lib.callback.register('qbx_outfitbag:server:hasItem', function(source)
    local Player = exports.qbx_core:GetPlayer(source)
    if not Player then return false end
    
    local hasItem = Player.Functions.GetItemByName(Config.OutfitBagItem)
    return hasItem and hasItem.amount > 0
end)

local bagOwners = {}

lib.callback.register('qbx_outfitbag:server:checkBagOwnership', function(source, netId)
    return bagOwners[netId] == source
end)

RegisterNetEvent('qbx_outfitbag:server:syncBagOwnership', function(netId)
    local src = source
    if not netId then return end
    
    bagOwners[netId] = src
    
    TriggerClientEvent('qbx_outfitbag:client:syncBagOwnership', -1, netId, src)
end)

RegisterNetEvent('qbx_outfitbag:server:removeBagOwnership', function(netId)
    local src = source
    if not netId or bagOwners[netId] ~= src then return end
    
    bagOwners[netId] = nil
    
    TriggerClientEvent('qbx_outfitbag:client:removeBagOwnership', -1, netId)
end)

AddEventHandler('playerDropped', function()
    local src = source
    
    for netId, owner in pairs(bagOwners) do
        if owner == src then
            bagOwners[netId] = nil
            TriggerClientEvent('qbx_outfitbag:client:removeBagOwnership', -1, netId)
        end
    end
end)