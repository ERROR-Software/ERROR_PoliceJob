local isCuffed = false

exports.ox_target:addGlobalPlayer({
    {
        distance = 1.5,
        name = "cuff",
        icon = "fa-solid fa-handcuffs",
        label = _U('cuff'),
        groups = {Config.jobname},
        onSelect = function(a)
            local player, dst = ESX.Game.GetClosestPlayer()
            TriggerServerEvent("ERROR_PoliceJob:CuffPlayer", GetPlayerServerId(player))
            PlayAnim(PlayerPedId(), Config.PlayersInteractions['uncuff'].animDict, Config.PlayersInteractions['uncuff'].animName)
        end
    },
    {
        distance = 1.5,
        name = "search",
        icon = "fa-solid fa-magnifying-glass",
        label = _U('search'),
        groups = {Config.jobname},
        onSelect = function()
            local player, dst = ESX.Game.GetClosestPlayer()
            exports.ox_inventory:openInventory('player', GetPlayerServerId(player))
        end
    },
    {
        distance = 1.5,
        name = "gab",
        icon = "fa-solid fa-hand",
        label = _U('grab'),
        groups = {Config.jobname},
        onSelect = function()
            local player, dst = ESX.Game.GetClosestPlayer()
            TriggerServerEvent("ERROR_PoliceJob:GrabPlayer", {
                target = GetPlayerServerId(player),
                entity = NetworkGetNetworkIdFromEntity(PlayerPedId())
            })
        end
    },
    {
        distance = 1.5,
        name = "bill",
        icon = "fa-solid fa-scroll",
        label = _U('bill'),
        groups = {Config.jobname},
        onSelect = function()
            local player, dst = ESX.Game.GetClosestPlayer()
            local input = lib.inputDialog(_U('bill_menu'), {
                {type = 'number', label = _U('bill_amount')},
            })
            if not input or not input[1] then return ESX.ShowNotification(_U('bill_error'), "error") end
            TriggerServerEvent("esx_billing:sendBill", GetPlayerServerId(player), Config.jobname, _U('bill_name', tonumber(input[1])), tonumber(input[1]))
        end
    },
    {
        distance = 1.5,
        name = "take",
        icon = "fa-solid fa-car",
        label = _U('put_car'),
        groups = {Config.jobname},
        onSelect = function()
            local player, dst = ESX.Game.GetClosestPlayer()
            local vehicle, vdist = ESX.Game.GetClosestVehicle()
            if (vdist > 3.5) then
                ESX.ShowNotification(_U('car_error'), "error")
                return false
            end
            TriggerServerEvent("ERROR_PoliceJob:PlayerInteractVeh", {
                veh = NetworkGetNetworkIdFromEntity(vehicle),
                target = GetPlayerServerId(player)
            })
        end
    },
})

RegisterNetEvent("ERROR_PoliceJob:CuffPlayer", function(player)
    local ped = PlayerPedId()
    local auth = NetToEnt(player.netid)
    SetEntityHeading(ped, GetEntityHeading(auth))
    Wait(800)
    if (player.typee == "cuff") then
        isCuffed = true
        PlayAnim(ped, Config.PlayersInteractions['cuff'].animDict, Config.PlayersInteractions['cuff'].animName, -1, true)
        SetEnableHandcuffs(ped, true)
        DisablePlayerFiring(ped, true)
        SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true)
        DisplayRadar(false)
        SetPedCanPlayAmbientBaseAnims(ped, false)
        ESX.ShowNotification(_U('cuffed', player.name))
        exports.ox_inventory:weaponWheel(true)
        if (Config.PlayersInteractions['cuff'].freeze) then FreezeEntityPosition(PlayerPedId(), true) end
    else
        Wait((math.floor(GetAnimDuration(Config.PlayersInteractions['cuff'].animDict, "a_uncuff"))-1)*1000)
        isCuffed = false
        StopAnimTask(ped, Config.PlayersInteractions['cuff'].animDict, Config.PlayersInteractions['cuff'].animName, 1.0)
        SetEnableHandcuffs(ped, false)
        SetPedCanPlayAmbientBaseAnims(ped, true)
        DisablePlayerFiring(ped, false)
        DisplayRadar(true)
        ESX.ShowNotification(_U('uncuffed', player.name))
        exports.ox_inventory:weaponWheel(false)
        if (Config.PlayersInteractions['cuff'].freeze) then FreezeEntityPosition(PlayerPedId(), false) end
    end
end)


RegisterNetEvent("ERROR_PoliceJob:PlayerInteractVeh", function(netid)
    local closestVehicle = NetToVeh(netid)
    for i = 1, GetVehicleModelNumberOfSeats(GetEntityModel(closestVehicle))-2 do
        if (GetPedInVehicleSeat(closestVehicle, i) == 0) then
            SetPedIntoVehicle(PlayerPedId(), closestVehicle, i)
            break
        end
    end
end)

RegisterNetEvent("ERROR_PoliceJob:GrabPlayer", function(src)
    local src = NetToEnt(src)
    local offset = vector3(0.1, 0.0, 0.0)
    local rotation = vector3(0.0, 0.0, 0.0)
    if (not IsEntityAttached(PlayerPedId())) then
        AttachEntityToEntity(PlayerPedId(), src, GetPedBoneIndex(playerPed, 57005), offset.x, offset.y+0.5, offset.z, rotation.x, rotation.y, rotation.z, false, false, true, false, 2, true)
    else
        DetachEntity(PlayerPedId())
    end
end)

CreateThread(function()
    while (function()
        if (isCuffed) then
            if (not IsEntityPlayingAnim(PlayerPedId(), Config.PlayersInteractions['cuff'].animDict, Config.PlayersInteractions['cuff'].animName, 49)) then
                PlayAnim(PlayerPedId(), Config.PlayersInteractions['cuff'].animDict, Config.PlayersInteractions['cuff'].animName, -1, true)
            end
        end
        return true
    end) () do
        Wait(1000)
    end
end)