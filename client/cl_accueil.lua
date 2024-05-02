local main = RageUI.CreateMenu(("Accueil %s"):format(Config.copLabel), GetPlayerName(PlayerId()))
local canCall, canComplaint = true, true

local npc = SpawnNpc(Config.accueil['npcmodel'], table.unpack(Config.accueil['pos']))
local blip = CreateBlip(_U("blip"), 63, 60, table.unpack(Config.accueil['pos']))
exports.ox_target:addLocalEntity(npc.model, {
    distance = Config.accueil['interact_dst'],
    icon = 'fa-solid fa-user', 
    label = _U("task_acceuil_npc"), 
    onSelect = function()
        lib.showContext("some_menu")
    end,
    canInteract = function(entity, distance, data) 
        return true
    end
})

lib.registerContext({
    id = 'some_menu',
    title = _U("menu_title"),
    options = {
      {
        title = _U("call_cop"),
        description = _U("call_cop_info"),
        onSelect = function()
            if (not canCall) then return ESX.ShowNotification(_U("can_call_cop", Config.accueil['timeforcallpolice']), "error") end
            canCall = false
            ESX.ShowNotification(_U("call_success"))
            TriggerServerEvent("error:AlertPolice")
            SetTimeout(Config.accueil['timeforcallpolice']*1000, function() canCall = true end)
        end,
      },
      {
        title = _U("complaint"),
        description = _U("complaint_info"),
        onSelect = function()
          local input = lib.inputDialog('Informations sur la plainte', {
            {type = 'number', label = 'Numero de téléphone', required = true},
            {type = 'input', label = 'Motif de la plainte', required = true, min = 10, max = 450},
          })
          if not input then return ESX.ShowNotification(_U("complaint_error"), "error") end
          TriggerServerEvent("error:SendDiscordLog", Config.accueil['webhook'].bot_name, Config.accueil['webhook'].message_title, (Config.accueil['webhook'].message):format(input[1], ESX.PlayerData.firstName.." "..ESX.PlayerData.lastName, input[2]), Config.accueil['webhook'].footer, Config.accueil['webhook'].color, Config.accueil['complaint_webhook'])
        end
      },

    }
})