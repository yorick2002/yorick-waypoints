local ui = false

RegisterNUICallback('setVisible', function(data, cb)
    SetNuiFocus(data.visible, data.visible)
    cb({ status = 'ok' })
end)

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
    SetEntityCoords(player, tonumber(data.coordX), tonumber(data.coordY), tonumber(data.coordZ) - 1.0, false, true, false,
        false)
    cb()
end)
