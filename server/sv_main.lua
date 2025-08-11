TriggerEvent('esx_society:registerSociety', Config.jobname, Config.copLabel, 'society_'..Config.jobname, 'society_'..Config.jobname, 'society'..Config.jobname, {type = 'public'})

local cuffed_players = {}

local function HashPasswd(passwd)
    return tonumber(GetHashKey(passwd))*8974
end

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    exports.ox_inventory:RegisterStash(Config.Saisies['StashName'], ("Saisies %s"):format(Config.copLabel), Config.Saisies['slots'], Config.Saisies['weight'], nil, Config.jobname)
end)

RegisterNetEvent("error:AlertPolice", function()
    for k,v in pairs(ESX.GetExtendedPlayers()) do
        if (v.job.name == Config.jobname) then
            TriggerClientEvent('esx:showAdvancedNotification', v.source, Config.copLabel, "information", _U("cop_msg"), Config.accueil['char'])
        end
    end
end)

local function SendDiscordLog(botname, title, msg, footer, color, webhook)
    PerformHttpRequest(webhook, function(err, txt)
    end, 'POST', json.encode({username = botname, embeds = {
        {
            ['color'] = color,
            ['title'] = title,
            ['description'] = msg,
            ['footer'] = {
                ['text'] = footer
            }
        }
    }}), {['Content-Type'] = 'application/json'})
end

RegisterNetEvent("error:SendDiscordLog", SendDiscordLog)

RegisterNetEvent("error:GivePlayerWeapon", function(type, item, count)
    if (type == "add") then
        ESX.GetPlayerFromId(source).addInventoryItem(item, count)
    elseif type == "remove" then
        ESX.GetPlayerFromId(source).removeInventoryItem(item, count)
    end
end)

RegisterNetEvent("ERROR_PoliceJob:CuffPlayer", function(id)
    local _src = source
    local license = ESX.GetIdentifier(id)
    if (not cuffed_players[license]) then
        cuffed_players[license] = true
    else
        cuffed_players[license] = false
    end
    TriggerClientEvent("ERROR_PoliceJob:CuffPlayer", id, {
        name = ESX.GetPlayerFromId(_src).name,
        netid = NetworkGetNetworkIdFromEntity(GetPlayerPed(_src)),
        typee = cuffed_players[license] and 'cuff' or 'uncuff'
    })
end)

RegisterNetEvent("ERROR_PoliceJob:PlayerInteractVeh", function(data)
    TriggerClientEvent("ERROR_PoliceJob:PlayerInteractVeh", data.target, data.veh)
end)

RegisterNetEvent("ERROR_PoliceJob:GrabPlayer", function(data)
    TriggerClientEvent("ERROR_PoliceJob:GrabPlayer", data.target, data.entity)
end)

ESX.RegisterServerCallback("ERROR_PoliceJob:GetVehicleOwner", function(src, cb, plate)
    MySQL.query("SELECT * FROM owned_vehicles WHERE plate = ?", {plate}, function(vehicle)
        if (not vehicle[1]) then cb(false) else cb(ESX.GetPlayerFromIdentifier(vehicle[1].owner).getName()) end
    end)
end)

ESX.RegisterServerCallback("ERROR_PoliceJob:GetSocietyMoney", function(source, cb)
    TriggerEvent('esx_addonaccount:getSharedAccount', "society_"..Config.jobname, function(account)
        cb(account.money)
      end)
end)

ESX.RegisterServerCallback("ERROR_PoliceJob:OpenPersonalLocker", function(src, cb, lockerCode, lockerPasswd)
    local xPlayer = ESX.GetPlayerFromId(src)
    local hashedPasswd = HashPasswd(lockerPasswd)
    MySQL.query("SELECT * FROM police_lockers WHERE code = ? AND passwd = ?", {lockerCode, hashedPasswd}, function(result)
        if result[1] then
            local stashid = ("police_locker_%s"):format(xPlayer.identifier)
            exports.ox_inventory:RegisterStash(
                stashid,
                _U('locker_data'),
                Config.PersonalLocker.slots,
                Config.PersonalLocker.weight,
                nil,
                "police"
            )
            cb({id = stashid})
        else
            cb(false)
        end
    end)
end)

-- ERROR_PoliceJob:createLocker

RegisterNetEvent("ERROR_PoliceJob:createLocker", function(lockerCode, lockerPasswd)
    if not lockerCode or not lockerPasswd then
        return
    end
    local hashedPasswd = HashPasswd(lockerPasswd)
    MySQL.query("SELECT * FROM police_lockers WHERE code = ?", {lockerCode}, function(result)
        if not result[1] then
            MySQL.insert("INSERT INTO police_lockers (code, passwd) VALUES (?, ?)", {
                lockerCode, hashedPasswd
            })
        end
    end)
end)

ESX.RegisterServerCallback("ERROR_PoliceJob:ListLockers", function(src, cb)
    MySQL.query("SELECT * FROM police_lockers", {}, function(results)
        local list = {}
        for _, locker in ipairs(results) do
            table.insert(list, locker.code)
        end
        cb(list)
    end)
end)

RegisterNetEvent("ERROR_PoliceJob:ModifyLocker", function(action, lockerCode, newCode, newPasswd)
    if not action or not lockerCode then return end

    if action == "delete" then
        MySQL.query("DELETE FROM police_lockers WHERE code = ?", {lockerCode})
    elseif action == "update_code" and newCode then
        MySQL.query("UPDATE police_lockers SET code = ? WHERE code = ?", {newCode, lockerCode})
    elseif action == "update_passwd" and newPasswd then
        local hashedPasswd = HashPasswd(newPasswd)
        MySQL.query("UPDATE police_lockers SET passwd = ? WHERE code = ?", {hashedPasswd, lockerCode})
    elseif action == "update_both" and newCode and newPasswd then
        local hashedPasswd = HashPasswd(newPasswd)
        MySQL.query("UPDATE police_lockers SET code = ?, passwd = ? WHERE code = ?", {newCode, hashedPasswd, lockerCode})
    end
end)