ESX = exports[“es_extended”]:getSharedObject()

local sprayData = {} 


ESX.RegisterServerCallback('ks-spray:hasSpray', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local spray = xPlayer.getInventoryItem('spray')

    if spray and spray.count > 0 then
        cb(true)
    else
        cb(false)
    end
end)


RegisterNetEvent('ks-spray:removeSpray', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('spray', 1)
end)


RegisterNetEvent('ks-spray:displaySprayText', function(sprayText, coords, entity)
    local sprayId = #sprayData + 1 
    sprayData[sprayId] = {text = sprayText, coords = coords, entity = entity}

    
    TriggerClientEvent('ks-spray:showSprayText', -1, sprayText, coords, entity, sprayId)
end)


RegisterNetEvent('ks-spray:removeSprayText', function(sprayId)
    if sprayData[sprayId] then
        sprayData[sprayId] = nil 
        
        TriggerClientEvent('ks-spray:removeSprayTextClient', -1, sprayId)
    end
end)


ESX.RegisterServerCallback('ks-spray:getNearbySpray', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerCoords = xPlayer.getCoords()

    for sprayId, spray in pairs(sprayData) do
        if #(playerCoords - spray.coords) < 3.0 then 
            cb(sprayId)
            return
        end
    end

    cb(nil) 
end)


