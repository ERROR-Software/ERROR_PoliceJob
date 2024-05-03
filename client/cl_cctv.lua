local canCancel = false
local cam
last_coords = ""

local function QuitCamThread(cam) -- Passer la caméra en paramètre
    return CreateThread(function()
        while true do
            if (not lib.isTextUIOpen()) then
                lib.showTextUI(_U('quit_cam'), {position = "left-center"})
            end
            if (IsControlJustPressed(0, 51)) then
                DestroyCamm(cam)
                lib.hideTextUI()
                break
            end
            Wait(0)
        end
    end)
end

local function GetAllCams()
    local options = {}
    for k,v in pairs(Config.Cctv['cams']) do
        options[#options+1] = {
            title = v.label,
            onSelect = function()
                cam = CreateCameraa(v['coords'].x, v['coords'].y, v['coords'].z, v['coords'].w, v['rotX'])
                last_coords = GetEntityCoords(PlayerPedId())
                SetEntityCoords(PlayerPedId(), v['coords'].x, v['coords'].y, v['coords'].z+20)
                QuitCamThread()
            end
        }
    end
    return options
end

CreateThread(function()
    local msec, dst
    while (function()
        msec = 1000
        if (not ESX.PlayerData.job or ESX.PlayerData.job.name ~= Config.jobname) then return true end
        dst = #(GetEntityCoords(PlayerPedId()) - Config.Cctv['interact_pos'])
        if (dst > Config.Cctv['markerZone']) then return true end
        msec = 0
        DrawMarker(Config.Markers['id'], Config.Cctv['interact_pos'].x, Config.Cctv['interact_pos'].y, Config.Cctv['interact_pos'].z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, Config.Markers['color'][1], Config.Markers['color'][2], Config.Markers['color'][3], 50, Config.Markers['animate'], true, 2, Config.Markers['turn'], nil, false)
        if (dst > Config.Cctv['interactZone']) then
            if (lib.isTextUIOpen()) then lib.hideTextUI() end
            return true 
        end
        if (not lib.isTextUIOpen()) then
            lib.showTextUI(_U('cctv_interaction'), {position = "left-center"})
        end
        if (IsControlJustPressed(0, 51)) then
            lib.registerContext({
                id = 'cctv_menu',
                title = _U('cctv_menuname'),
                options = GetAllCams()
            })
            lib.showContext('cctv_menu')
        end
        return true
    end) () do
        Wait(msec)
    end
end)

RegisterCommand("cancelcam", DestroyCamm)