-- Server-side logic (if needed, could be used for tracking or syncing if required)

-- Example of tracking or syncing weapon data (if needed)
RegisterNetEvent('gunJamSync')
AddEventHandler('gunJamSync', function(jammed)
    local src = source
    -- Here you could store jam status or sync across the server
    -- TriggerClientEvent('gunJamStatus', src, jammed)  -- For example, sync across clients
end)
