RegisterNetEvent("yorick-waypoints:createNew")
AddEventHandler("yorick-waypoints:createNew", function(data)

    local playerName = GetPlayerName(source)
    local playerLicense2 = {}

    playerLicense2[source] = GetPlayerIdentifierByType(source, 'license2')

    MySQL.insert.await('INSERT INTO `waypoints` (name, x, y, z, description) VALUES (?,?,?,?,?)', {
        data.waypointName,
        data.waypointCoordsX,
        data.waypointCoordsY,
        data.waypointCoordsZ,
        data.waypointDescription,
    })

    MySQL.insert.await('INSERT INTO `players` (license2, playername) VALUES (?,?)', {
        playerName,
        playerLicense2
    })

end)
