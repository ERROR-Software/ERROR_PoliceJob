local cuffed_players = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if (xPlayer.job.name ~= Config.jobname) then return false end
    local stashid = ("%s-police"):format(xPlayer.getIdentifier())
    MySQL.query("SELECT * FROM ox_inventory WHERE name = ?", {stashid}, function(res)
        if not res[1] then
            exports.ox_inventory:RegisterStash(stashid, ("Casier %s"):format(Config.copLabel), Config.PersonalLocker['slots'], Config.PersonalLocker['weight'], xPlayer.getIdentifier(), Config.jobname)
        end
    end)
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