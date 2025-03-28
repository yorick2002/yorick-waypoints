RegisterNetEvent("yorick-waypoints:sv_deleteWaypoint", function(data)
    local waypointId = data.itemId

    MySQL.query.await([[
        DELETE FROM yorick_waypoints WHERE id = ?
    ]], { waypointId })
end)
