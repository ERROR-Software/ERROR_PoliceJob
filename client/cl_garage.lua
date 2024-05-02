local npc = SpawnNpc(Config.garage['npc'], table.unpack(Config.garage['coords']))

local function GetAllPoliceVeh()
    local c = {}
    for _,v in pairs(Config.garage['vehicles'][ESX.PlayerData.job.grade]) do
        c[#c+1] = {
            title = v.label,
            onSelect = function()
                for _,p in pairs(Config.garage['parks']) do
                    if (not IsAnyVehicleNearPoint(p.x, p.y, p.z, Config.garage['parkradius'])) then
                        ESX.Game.SpawnVehicle(v.name, vec3(p.x, p.y, p.z), p.w, function() 
                            
                        end)
                        break
                    end
                end
            end
        }
    end
    return c
end

exports.ox_target:addLocalEntity(npc.model, {
    distance = Config.garage['interact_dst'],
    icon = 'fa-solid fa-car', 
    label = _U("garage_menu", Config.copLabel), 
    onSelect = function()
        if (ESX.PlayerData.job.name ~= Config.jobname) then return ESX.ShowNotification(_U('not_job'), "error") end
        lib.registerContext({
            id = 'garage_menu',
            title = _U("armory_titlee"),
            options = GetAllPoliceVeh()
        })
        lib.showContext("garage_menu")
    end,
    canInteract = function(entity, distance, data) 
        return true
    end
})

CreateThread(function()
    local msec
    while (function()
        msec = 1000
        if (not ESX.PlayerData.job) then return true end
        if (ESX.PlayerData.job.name ~= Config.jobname) then return true end
        if (not IsPedInAnyVehicle(PlayerPedId())) then 
            if (lib.isTextUIOpen()) then lib.hideTextUI() end
            return true 
        end
        if #(GetEntityCoords(PlayerPedId()) - Config.garage['deleteVehicles']) > Config.garage['DeleteInteractDist'] then return true end
        msec = 0
        if (Config.Markers) then
            DrawMarker(Config.Markers['id'], Config.garage['deleteVehicles'].x, Config.garage['deleteVehicles'].y, Config.garage['deleteVehicles'].z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
        end
        lib.showTextUI(_U('delete_veh'), {position = "left-center"})
        if (IsControlJustPressed(0, 51)) then
            DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
        end
        return true
    end) () do
        Wait(msec)
    end
end)