RegisterNetEvent("yorick-waypoints:sv_createNew", function(data)
    local playerName = GetPlayerName(source)
    local playerLicense2 = GetPlayerIdentifierByType(source, 'license2')

    MySQL.insert(
    "INSERT INTO `players` (license2, playername) VALUES (?,?) ON DUPLICATE KEY UPDATE playername = VALUES(playername)",
        {
            playerLicense2, playerName
        }, function()
        MySQL.query("SELECT `id` FROM `players` WHERE `license2` = ?", { playerLicense2 }, function(result)
            if result and result[1] then
                MySQL.insert(
                "INSERT INTO `waypoints` (`name`, `x`, `y`, `z`, `description`, `player_id`) VALUES (?, ?, ?, ?, ?, ?)",
                    {
                        data.waypointName,
                        data.waypointCoordsX,
                        data.waypointCoordsY,
                        data.waypointCoordsZ,
                        data.waypointDescription,
                        result[1].id
                    })
            else
                print("Player not found!")
            end
        end)
    end)
end)
