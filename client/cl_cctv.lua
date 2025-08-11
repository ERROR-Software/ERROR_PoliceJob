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
    for k, v in pairs(Config.Cctv['cams']) do
        options[#options+1] = {
            title = v.label,
            icon = v.icon or 'fa-solid fa-video', -- Ajoute une icône, ou celle par défaut
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

exports.ox_target:addBoxZone({
    coords = vec3(Config.Cctv['interact_pos'].x, Config.Cctv['interact_pos'].y, Config.Cctv['interact_pos'].z),
    size = vec3(1, 1, 1),
    rotation = 0,
    debug = false,
    options = {
        {
            name = 'cctv_interaction',
            icon = 'fa-solid fa-video',
            label = _U('cctv_interaction'),
            distance = Config.Cctv['interactZone'],
            canInteract = function(entity, distance, coords, name)
                return ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname
            end,
            onSelect = function(data)
                lib.registerContext({
                    id = 'cctv_menu',
                    title = _U('cctv_menuname'),
                    options = GetAllCams()
                })
                lib.showContext('cctv_menu')
            end
        }
    }
})

RegisterCommand("cancelcam", DestroyCamm)