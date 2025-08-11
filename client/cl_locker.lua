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
            icon = 'fa-solid fa-user',
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
            icon = v.icon or 'fa-solid fa-shirt',
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
    groups = {Config.jobname},
    debug = Config.Debug,
    drawSprite = false,
    options = {
        {
            name = 'sphere',
            icon = 'fa-solid fa-shirt',
            label = _U("open_locker"),
            onSelect = function()
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