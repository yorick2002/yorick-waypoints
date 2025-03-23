RegisterNetEvent("yorick-waypoints:sv_createNew", function(data)
    local playerLicense2 = GetPlayerIdentifierByType(source, 'license2')

    MySQL.single(
        "INSERT INTO `yorick_players` (license2) VALUES (?) ON DUPLICATE KEY UPDATE license2=VALUES(license2) RETURNING id",
        { playerLicense2 }, function(row)
            if not row then return end

            MySQL.insert.await(
                "INSERT INTO `yorick_waypoints` (`name`, `x`, `y`, `z`, `description`, `player_id`) VALUES (?, ?, ?, ?, ?, ?) ",
                {
                    data.waypointName,
                    data.waypointCoordsX,
                    data.waypointCoordsY,
                    data.waypointCoordsZ,
                    data.waypointDescription,
                    row.id
                }
            )
        end
    )
end)
