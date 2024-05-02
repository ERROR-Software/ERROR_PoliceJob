local function setUniform(id)
    local sx = ESX.PlayerData.job.sex == "m" and "male" or "female"
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadClothes', skin, Config.locker[ESX.PlayerData.job.grade][id][sx])
    end)
end

local function LoadClothes()
    local c = {
        {
            title = _U("personal_clothes"),
            onSelect = function()
                ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(old_skin) 
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerEvent('skinchanger:loadClothes', skin, old_skin)
                    end)
                end)
            end
        }
    }
    for k,v in pairs(Config.locker[ESX.PlayerData.job.grade]) do
        table.insert(c, {
            title = v.label,
            onSelect = function()
                setUniform(k)
            end
        })
    end
    return c
end


exports.ox_target:addSphereZone({
    coords = Config.locker['pos'],
    radius = 1.2,
    debug = false,
    drawSprite = false,
    options = {
        {
            name = 'sphere',
            icon = 'fa-solid fa-shirt',
            label = _U("open_locker"),
            onSelect = function()
                if (ESX.PlayerData.job.name ~= Config.jobname) then return ESX.ShowNotification(_U('not_job'), "error") end
                lib.registerContext({
                    id = 'police_locker',
                    title = 'Agent de police',
                    options = LoadClothes()
                })
                lib.showContext("police_locker")
            end
        }
    }
})