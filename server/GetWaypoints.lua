RegisterNetEvent("yorick-waypoints:sv_getWaypoints", function(data)
    local src = source
    local playerLicense2 = GetPlayerIdentifierByType(source, 'license2')

    local result = MySQL.query.await([[
        SELECT w.*
        FROM yorick_waypoints w
        JOIN yorick_players p ON w.player_id = p.id
        WHERE p.license2 = ?
    ]], { playerLicense2 })

    if result then
        for i = 1, #result do
            local row = json.encode(result[i])

            TriggerClientEvent("yorick-waypoints:cl_getWaypoints", src, row)
        end
    end
end)