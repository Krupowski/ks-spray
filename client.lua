ESX = exports[“es_extended”]:getSharedObject()

local duiObject = nil

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

                        
                        createTextDUI(sprayText, coords)
                    else
                        lib.notify({ type = 'inform', description = 'Spray cancelled.' })
                    end
                end)
            end
        }
    })
end)


function createTextDUI(text, coords)
    local htmlCode = string.format([[
        <html>
        <body style="margin: 0; background: transparent;">
            <div style="font-size: 50px; color: white;">%s</div>
        </body>
        </html>
    ]], text)

    
    duiObject = CreateDui(htmlCode, 512, 512) 

    
    local duiHandle = GetDuiHandle(duiObject)
    local texture = CreateRuntimeTextureFromDuiHandle(duiHandle, "text_texture")

    
    DrawSprite("text_texture", "default", coords.x, coords.y, 0.1, 0.1, 0.0, 255, 255, 255, 255)
end



