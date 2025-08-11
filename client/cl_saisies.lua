exports.ox_target:addSphereZone({
    coords = Config.Saisies['pos'],
    radius = Config.Saisies['interactZone'],
    debug = Config.Debug,
    options = {
        {
            name = 'saisie_stash',
            icon = 'fa-solid fa-box-open',
            label = _U('chest_interaction'),
            onSelect = function()
                exports.ox_inventory:openInventory('stash', Config.Saisies['StashName'])
            end,
            canInteract = function(entity, distance, coords, name)
                return ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname
            end,
        }
    }
})
