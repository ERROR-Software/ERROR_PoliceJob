exports.ox_target:addSphereZone({
    coords = Config.PersonalLocker['pos'],
    radius = 1.2,
    distance = 1.2,
    rotation = 0,
    debug = Config.Debug,
    options = {
        {
            name = 'police_locker',
            icon = 'fas fa-lock',
            label = _U('open_personal_locker'),
            onSelect = function()
                local input = lib.inputDialog(_U('locker_data'), {
                    {type = "number", min = 0, label = _U('locker_code'), required = true},
                    {type = "input", label = _U('locker_passwd'), required = true, password = true}
                })
                if not input or not input[1] or not input[2] then return end
                ESX.TriggerServerCallback("ERROR_PoliceJob:OpenPersonalLocker", function(data)
                    if data then
                        exports.ox_inventory:openInventory("stash", {id = data.id})
                    else
                        lib.notify({
                            title = _U('locker_error'),
                            description = _U('locker_invalid'),
                            type = 'error'
                        })
                    end
                end, input[1], input[2])
            end,
            canInteract = function(entity, distance, coords, name)
                return ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname
            end,
        }
    },
})