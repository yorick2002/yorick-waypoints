local ui = false

function SendSvelteMessage(action, data)
    SendNUIMessage({ action = action, data = data })
end

RegisterCommand("waypoints", function()
    ui = not ui
    if ui then
        SendSvelteMessage("openMenu", { ShowUI = true })
        SetNuiFocus(true, true)
    else
        SendSvelteMessage("openMenu", { ShowUI = false })
        SetNuiFocus(false, false)
    end
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
    SetEntityCoords(player, data.coordX, data.coordY, data.coordZ -1.0, false, true, false, false)
    cb()
end)