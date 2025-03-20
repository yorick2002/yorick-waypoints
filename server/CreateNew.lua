RegisterNetEvent("yorick-waypoints:sv_createNew", function(data)
    local playerName = GetPlayerName(source)
    local playerLicense2 = {}

    playerLicense2[source] = GetPlayerIdentifierByType(source, 'license2')

    MySQL.insert.await('INSERT INTO `players` (license2, playername) VALUES (?,?)', {
        playerLicense2,
        playerName,
    })

    MySQL.query("SELECT `id` FROM `players` WHERE `license2` = ?", { playerLicense2 }, function(result)
        if result[1] then
            local playerId = result[1].id

            MySQL.query(
                "INSERT INTO `waypoints` (`name`, `x`, `y`, `z`, `description`, `player_id`) VALUES (?, ?, ?, ?, ?, ?)",
                {
                    data.waypointName,
                    data.waypointCoordsX,
                    data.waypointCoordsY,
                    data.waypointCoordsZ,
                    data.waypointDescription,
                    playerId
                })
        else
            print("Player not found!")
        end
    end)
end)
