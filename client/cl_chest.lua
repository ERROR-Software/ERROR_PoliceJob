    exports.ox_target:addBoxZone({
        coords = Config.Chest['pos'],
        size = vec3(1, 1, 1),
        rotation = 0,
        debug = false,
        drawSprite = true,
        options = {
            {
                name = 'police_chest',
                icon = 'fa-solid fa-box',
                groups = {Config.jobname},
                label = _U('chest_interaction'),
                onSelect = function()
                    exports.ox_inventory:openInventory('stash', 'society_police')
                end,
                canInteract = function(entity, distance, coords, name)
                    return ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname
                end,
            }
        }
    })