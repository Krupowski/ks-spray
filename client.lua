ESX = exports[“es_extended”]:getSharedObject()

RegisterNetEvent('ks-spray:useSpray', function()
    ESX.TriggerServerCallback('ks-spray:hasSpray', function(hasSpray)
        if hasSpray then
           
            local input = lib.inputDialog('Enter Spray Text', {
                { type = 'input', label = 'Spray Text', placeholder = 'Your message here...' }
            })

           
            if input and input[1] ~= '' then
                TriggerEvent('ks-spray:startSpray', input[1]) 
            else
                lib.notify({ type = 'error', description = 'You must enter a valid text to spray!' })
            end
        else
            lib.notify({ type = 'error', description = 'You need a spray to do this.' })
        end
    end)
end)


RegisterNetEvent('ks-spray:startSpray', function(sprayText)
    exports.ox_target:addGlobalObject({
        {
            label = "Spray Here",
            distance = 2.0,
            icon = 'paint-brush',
            onSelect = function(entity)
                local coords = GetEntityCoords(entity)
                
             
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
                    
                        TriggerServerEvent('ks-spray:removeSpray')
                        TriggerServerEvent('ks-spray:displaySprayText', sprayText, coords, entity)
                    else
                        lib.notify({ type = 'inform', description = 'Spray cancelled.' })
                    end
                end)
            end
        }
    })
end)


RegisterNetEvent('ks-spray:showSprayText', function(sprayText, coords, entity, sprayId)
    Citizen.CreateThread(function()
        local removeTime = GetGameTimer() + 3600000 

        while true do
            if GetGameTimer() > removeTime then
              
                TriggerServerEvent('ks-spray:removeSprayText', sprayId)
                break
            end

           
            if DoesEntityExist(entity) then
                DrawTextOnObject(entity, sprayText)
            end
            Citizen.Wait(0)
        end
    end)
end)


function DrawTextOnObject(entity, text)
    local entityCoords = GetEntityCoords(entity)
    local forwardVector = GetEntityForwardVector(entity)
    local textCoords = entityCoords + forwardVector * 0.5
    local scale = 0.35
    local onScreen, _x, _y = World3dToScreen2d(textCoords.x, textCoords.y, textCoords.z)
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end


