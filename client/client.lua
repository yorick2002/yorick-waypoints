local ui = false

RegisterCommand("waypoints", function(source, args)
    ui = not ui
    SendNUIMessage({
        type = "setVisible",
        data = {
            visible = ui
        }
    })
    SetNuiFocus(ui, ui)
end, false)

RegisterNUICallback('setVisible', function(data, cb)
    SetNuiFocus(data.visible, data.visible)
    cb({ status = 'ok' })
end)

RegisterNuiCallback("coords", function(data, cb)
    local player = PlayerPedId()
    local plyCoords = GetEntityCoords(player)
    local formattedCoords = {
        x = tonumber(string.format("%.2f", plyCoords.x)),
        y = tonumber(string.format("%.2f", plyCoords.y)),
        z = tonumber(string.format("%.2f", plyCoords.z))
    }
    cb((formattedCoords))
end)

RegisterNUICallback("closeMenu", function()
    ui = false
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
end)

RegisterNUICallback("teleportPlayer", function(data, cb)
    local player = PlayerPedId()
    ---@diagnostic disable-next-line: param-type-mismatch
    SetEntityCoords(player, tonumber(data.coordX), tonumber(data.coordY), tonumber(data.coordZ) - 1.0, false, true, false,
        false)
    cb(0)
end)

RegisterNUICallback("createNew", function(data, cb)
    TriggerServerEvent("yorick-waypoints:sv_createNew", data)
    cb(data)
end)

RegisterNUICallback("getWaypoints", function(data, cb)
    TriggerServerEvent("yorick-waypoints:sv_getWaypoints")
    cb({ status = 'ok' })
end)

RegisterNetEvent("yorick-waypoints:cl_getWaypoints")
AddEventHandler("yorick-waypoints:cl_getWaypoints", function(data)
    print(json.encode(data))
    SendNUIMessage({
        type = "getWaypoints",
        data = data
    })
end)

RegisterNUICallback("deleteWaypoint", function(data, cb)
    TriggerServerEvent("yorick-waypoints:sv_deleteWaypoint", data)
    cb({ status = 'ok' })
end)

RegisterNUICallback("toggleFavourite", function(data, cb)
    TriggerServerEvent("yorick-waypoints:sv_toggleFavourite", data)
    cb({ status = 'ok' })
end)



