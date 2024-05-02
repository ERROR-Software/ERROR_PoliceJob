CreateThread(function()
    local msec, dst
    while (function()
        msec = 1000
        if (not ESX.PlayerData.job or ESX.PlayerData.job.name ~= Config.jobname) then return true end
        dst = #(GetEntityCoords(PlayerPedId()) - Config.Chest['pos'])
        if (dst > Config.Chest['markerZone']) then return true end
        msec = 0
        DrawMarker(Config.Markers['id'], Config.Chest['pos'].x, Config.Chest['pos'].y, Config.Chest['pos'].z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, Config.Markers['color'][1], Config.Markers['color'][2], Config.Markers['color'][3], 50, Config.Markers['animate'], true, 2, Config.Markers['turn'], nil, false)
        if (dst > Config.Chest['interactZone']) then
            if (lib.isTextUIOpen()) then lib.hideTextUI() end
            return true 
        end
        if (not lib.isTextUIOpen()) then
            lib.showTextUI(_U('chest_interaction'), {position = "left-center"})
        end
        if (IsControlJustPressed(0, 51)) then
            exports.ox_inventory:openInventory('stash', 'society_police')
        end
        return true
    end) () do
        Wait(msec)
    end
end)