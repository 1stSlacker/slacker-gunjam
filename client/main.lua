local isGunJam = false
local shotCount = 0
local shotCooldown = Config.shotCooldown
local jamChance = Config.jamChance  -- 40% chance for the gun to jam
local reloadKey = Config.reloadKey

-- Track whether a notification has already been sent for the jam or reload
local hasNotifiedJam = false
local hasNotifiedReload = false

-- Triggering a shot
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Check if the player is holding a weapon
        if IsPedArmed(PlayerPedId(), 6) then
            -- Prevent shooting if the gun is jammed
            if isGunJam then
                -- Disable the fire action if the gun is jammed
                DisableControlAction(0, 24, true)  -- Left mouse button (fire)
                DisableControlAction(0, 257, true) -- Right mouse button (aim)

                -- Notify the player only once when the gun jams
                if not hasNotifiedJam then
                    TriggerEvent('QBCore:Notify', 'Your gun is jammed! Press "R" to reload.', 'error')
                    hasNotifiedJam = true  -- Set flag to prevent further notifications
                end
            else
                -- Detect shooting input (left mouse button)
                if IsControlJustPressed(0, 24) then
                    -- Simulate shooting process
                    shotCount = shotCount + 1

                    -- Add a small delay to prevent immediate jamming on the first shot
                    if shotCount > 1 then
                        -- Introduce a random chance for the gun to jam (based on Config.jamChance)
                        if math.random() < jamChance then
                            isGunJam = true
                            TriggerEvent('QBCore:Notify', 'Your gun has jammed!', 'error')
                            hasNotifiedJam = true  -- Notify about jam and set flag
                        end
                    end

                    -- Reset shotCount after cooldown period
                    Citizen.Wait(shotCooldown)
                end
            end
        end
    end
end)

-- Detect when the player presses "R" to reload and un-jam the gun
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if isGunJam and IsControlJustPressed(0, reloadKey) then
            -- Reload action
            TriggerEvent('QBCore:Notify', 'Reloading...', 'success')

            -- Simulate reloading process (this could be tied to actual reloading animations or mechanics)
            Citizen.Wait(Config.reloadTime)  -- Reload time (in ms)

            -- Un-jam the gun
            isGunJam = false
            hasNotifiedReload = false  -- Reset reload notification flag

            -- Notify the player only once when the gun is ready again
            TriggerEvent('QBCore:Notify', 'Your gun is ready to shoot again!', 'success')
            hasNotifiedJam = false  -- Reset jam notification flag
        end
    end
end)
