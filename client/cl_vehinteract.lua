local canInteract = false

local options = {
    {
        distance = 1.5,
        name = "freezeveh",
        label = _U('freezeveh'),
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
        icon = "fa-solid fa-clipboard-list",
        onSelect = function(d)
            ESX.TriggerServerCallback("ERROR_PoliceJob:GetVehicleOwner", function(owner)
                if (not owner) then ESX.ShowNotification(_U('ownerVeh_name')) else ESX.ShowNotification(_U('ownerVeh_namee', owner)) end
            end, GetVehicleNumberPlateText(d.entity))
        end
    },
    -- {
    --     distance = 1.5,
    --     name = "impound",
    --     label = _U('impound'),
    --     icon = "fa-solid fa-warehouse",
    --     onSelect = function(d)
            
    --     end
    -- },
}

local function AddVehInteractions()
    canInteract = true
    return exports.ox_target:addGlobalVehicle(options)
end

local function RemoveVehInteractions()
    local e = {}
    for k,v in pairs(options) do
        e[#e+1] = v.name
    end
    exports.ox_target:removeGlobalVehicle(e)
    canInteract = false
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    if (playerData.job.name ~= Config.jobname) then
        if (canInteract) then
            RemoveVehInteractions()
        end
        return false 
    end
    AddVehInteractions()
end)

RegisterNetEvent("esx:setJob", function(job)
    if (job.name ~= Config.jobname) then
        if (canInteract) then
            RemoveVehInteractions()
        end
        return false 
    end
    AddVehInteractions()
end)