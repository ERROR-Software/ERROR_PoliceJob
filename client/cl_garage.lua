local npc = SpawnNpc(Config.garage['npc'], table.unpack(Config.garage['coords']))

local function GetAllPoliceVeh()
    local c = {}
    for _,v in pairs(Config.garage['vehicles'][ESX.PlayerData.job.grade]) do
        c[#c+1] = {
            title = v.label,
            icon = v.icon or 'fa-solid fa-car', -- Ajoute une icône personnalisable ou celle par défaut
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
    groups = {Config.jobname},
    debug = Config.Debug,
    onSelect = function()
        lib.registerContext({
            id = 'garage_menu',
            title = _U("armory_titlee"),
            options = GetAllPoliceVeh()
        })
        lib.showContext("garage_menu")
    end,
})

CreateThread(function()
    local msec
    while true do
        msec = 1000
        if (not ESX.PlayerData.job) or (ESX.PlayerData.job.name ~= Config.jobname) or (not IsPedInAnyVehicle(PlayerPedId())) then
            if lib.isTextUIOpen() then lib.hideTextUI() end
            Wait(msec)
            goto continue
        end

        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = #(playerCoords - Config.garage['deleteVehicles'])
        if dist > Config.garage['DeleteInteractDist'] then
            if lib.isTextUIOpen() then lib.hideTextUI() end
            Wait(msec)
            goto continue
        end

        msec = 0
        if (Config.Markers) then
            DrawMarker(Config.Markers['id'], Config.garage['deleteVehicles'].x, Config.garage['deleteVehicles'].y, Config.garage['deleteVehicles'].z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, Config.Markers['color'][1], Config.Markers['color'][2], Config.Markers['color'][3], 50, Config.Markers['animate'], true, 2, Config.Markers['turn'], nil, false)
        end
        lib.showTextUI(_U('delete_veh'), {position = "left-center"})
        if (IsControlJustPressed(0, 51)) then
            DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
        end
        Wait(msec)
        ::continue::
    end
end)