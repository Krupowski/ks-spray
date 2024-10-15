ESX = exports[“es_extended”]:getSharedObject()


ESX.RegisterServerCallback('ks-spray:hasSprayCan', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sprayCan = xPlayer.getInventoryItem('spray')

    if sprayCan and sprayCan.count > 0 then
        cb(true)
    else
        cb(false)
    end
end)


RegisterNetEvent('ks-spray:removeSprayCan', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('spray', 1)
end)


RegisterNetEvent('ks-spray:displaySprayText', function(sprayText, coords)
    
    TriggerClientEvent('ks-spray:showSprayText', -1, sprayText, coords)
end)
