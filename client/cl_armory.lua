local npc = SpawnNpc(Config.armory['npc'], table.unpack(Config.armory['coords']))

local function GetAllWeapons()
    local c = {
        {
            title = _U("give_w"),
            onSelect = function()
                for k,v in pairs(Config.armory['weapons'][ESX.PlayerData.job.grade]) do
                    TriggerServerEvent("error:GivePlayerWeapon", "remove", v.name, 1)
                    if (v.ammo) then
                        TriggerServerEvent("error:GivePlayerWeapon", "remove", v.ammo, v.ammocount)
                    end
                end
            end
        }
    }

    for k,v in pairs(Config.armory['weapons'][ESX.PlayerData.job.grade]) do
        table.insert(c, {
            title = ESX.GetWeaponLabel(v.name),
            onSelect = function()
                TriggerServerEvent("error:GivePlayerWeapon", "add", v.name, 1)
                if (v.ammo) then
                    TriggerServerEvent("error:GivePlayerWeapon", "add", v.ammo, v.ammocount)
                end
            end
        })
    end
    return c
end
exports.ox_target:addLocalEntity(npc.model, {
    distance = Config.armory['interact_dst'],
    icon = 'fa-solid fa-user', 
    label = _U("armory_title"), 
    onSelect = function()
        if (ESX.PlayerData.job.name ~= Config.jobname) then return ESX.ShowNotification(_U('not_job'), "error") end
        lib.registerContext({
            id = 'armory_menu',
            title = _U("armory_titlee"),
            options = GetAllWeapons()
        })
        lib.showContext("armory_menu")
    end,
    canInteract = function(entity, distance, data) 
        return true
    end
})