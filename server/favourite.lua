RegisterNetEvent("yorick-waypoints:sv_toggleFavourite", function(data)
    local waypointId = data.waypointId
    local favourite = data.favourite

    MySQL.query.await([[
        UPDATE `yorick_waypoints` SET favourite = ? WHERE id = ?
    ]], { favourite, waypointId })
end)
