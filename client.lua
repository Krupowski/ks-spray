ESX = exports[“es_extended”]:getSharedObject()


RegisterNetEvent('ks-spray:useSprayCan', function()
    ESX.TriggerServerCallback('ks-spray:hasSprayCan', function(hasSprayCan)
        if hasSprayCan then
          
            local input = lib.inputDialog('Spray Text', {
                { type = 'input', label = 'Enter text to spray', placeholder = 'Your message here...' }
            })

            
            if input and input[1] ~= '' then
                
                TriggerEvent('ks-spray:startSpray', input[1])
            else
                lib.notify({ type = 'error', description = 'You must enter a valid text to spray!' })
            end
        else
            lib.notify({ type = 'error', description = 'You need a spray can to do this.' })
        end
    end)
end)


RegisterNetEvent('ks-spray:startSpray', function(sprayText)
    exports.ox_target:addGlobalObject({
        {
            label = "Spray Here",
            distance = 2.0,
            icon = 'paint-brush',
            onSelect = function(data)
                lib.progressBar({
                    duration = 5000,
                    label = 'Spraying...',
                    canCancel = true,
                    anim = {
                        dict = 'switch@trevor@trev_smoking_meth',
                        clip = 'trev_smoking_meth_loop',
                    }
                }).next(function(success)
                    if success then
                        lib.notify({ type = 'success', description = 'Spray completed!' })
                        TriggerServerEvent('ks-spray:removeSprayCan')
                        TriggerServerEvent('ks-spray:displaySprayText', sprayText, GetEntityCoords(PlayerPedId()))
                    else
                        lib.notify({ type = 'inform', description = 'Spray cancelled.' })
                    end
                end)
            end
        }
    })
end)


RegisterNetEvent('ks-spray:showSprayText', function(sprayText, coords)
    Citizen.CreateThread(function()
        local endTime = GetGameTimer() + 3000000
        while GetGameTimer() < endTime do
            DrawText3D(coords, sprayText)
            Wait(0)
        end
    end)
end)


function DrawText3D(coords, text)
    local x, y, z = table.unpack(coords)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local scale = 0.35
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end
