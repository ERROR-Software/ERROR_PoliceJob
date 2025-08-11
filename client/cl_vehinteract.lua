exports.ox_target:addGlobalVehicle({
    {
        distance = 1.5,
        name = "freezeveh",
        label = _U('freezeveh'),
        groups = {Config.jobname},
        icon = "fa-solid fa-ban",
        onSelect = function(d)
            PlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 3000)
            if (not IsEntityPositionFrozen(d.entity)) then
                FreezeEntityPosition(d.entity, true)
                ESX.ShowNotification(_U('freeze_success'), "success")
            else
                FreezeEntityPosition(d.entity, false)
                ESX.ShowNotification(_U('unfreeze_success'), "success")
            end
        end
    },
    {
        distance = 1.5,
        name = "checkplate",
        label = _U('checkplate'),
        groups = {Config.jobname},
        icon = "fa-solid fa-clipboard-list",
        onSelect = function(d)
            ESX.TriggerServerCallback("ERROR_PoliceJob:GetVehicleOwner", function(owner)
                if (not owner) then ESX.ShowNotification(_U('ownerVeh_name')) else ESX.ShowNotification(_U('ownerVeh_namee', owner)) end
            end, GetVehicleNumberPlateText(d.entity))
        end
    },
})