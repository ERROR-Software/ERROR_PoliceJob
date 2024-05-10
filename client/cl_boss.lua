local employe = {}

local function GetAllMoneyOptions()
    local money = ""
    ESX.TriggerServerCallback("ERROR_PoliceJob:GetSocietyMoney", function(moneyy) 
        money = moneyy
    end)
    while (money == "") do Wait(0) end
    return {
        {
            title = _U('s_money', money),
            disabled = true
        },
        {
            title = _U('deposit_money'),
            onSelect = function()
                local input = lib.inputDialog(_U('deposit_money'), {
                    { type = 'number', label = _U('money_number')},
                })
                if (not input or not input[1]) then return end
                TriggerServerEvent("esx_society:depositMoney", Config.jobname, tonumber(input[1]))
            end
        },
        {
            title = _U('withdraw_money'),
            disabled = not (money > 0),
            onSelect = function()
                local input = lib.inputDialog(_U('withdraw_money'), {
                    { type = 'number', label = _U('money_number')},
                })
                if (not input or not input[1]) then return end
                TriggerServerEvent("esx_society:withdrawMoney", Config.jobname, tonumber(input[1]))
            end
        },
    }
end

local function GetAllEmployesOptions()
    local buttons = {}
    ESX.TriggerServerCallback("esx_society:getEmployees", function(data) 
        for _,v in pairs(data) do
            buttons[#buttons+1] = {
                title = _U('employe_print', v.job.grade_label, v.name),
                onSelect = function()
                    employe = v
                    lib.registerContext({
                        id = 'employee_menu',
                        title = _U('employee_menu', employe.name),
                        options = {
                            {
                                title = _U('promote'),
                                onSelect = function()
                                    if (employe.job.grade < Config.MaxPoliceGrades and employe.identifier ~= ESX.PlayerData.identifier) then
                                        return ESX.TriggerServerCallback("esx_society:setJob", function() end, employe.identifier, Config.jobname, employe.job.grade+1, 'promote')
                                    end
                                    ESX.ShowNotification(_U('promote_error'), "error")
                                end
                            },
                            {
                                title = _U('fire'),
                                onSelect = function()
                                    if (employe.identifier ~= ESX.PlayerData.identifier) then
                                        ESX.TriggerServerCallback("esx_society:setJob", function() end, employe.identifier, "unemployed", 0, 'fire')
                                    else
                                        ESX.ShowNotification(_U('fire_error'), "error")
                                    end
                                end
                            },
                            {
                                title = _U('hire'),
                                onSelect = function()
                                    if (employe.identifier ~= ESX.PlayerData.identifier) then
                                        if (employe.job.grade > 0) then
                                            ESX.TriggerServerCallback("esx_society:setJob", function() end, employe.identifier, Config.jobname, employe.job.grade-1)
                                        else
                                            ESX.ShowNotification(_U('hire_error'), "error")
                                        end
                                    end
                                end
                            },
                        },
                    })
                    lib.showContext("employee_menu")
                end
            }
        end
    end, Config.jobname)
    while #buttons == 0 do Wait(0) end
    return buttons
end

CreateThread(function()
    local msec, dst
    while (function()
        msec = 1000
        if (not ESX.PlayerData.job or ESX.PlayerData.job.name ~= Config.jobname) then return true end
        if (ESX.PlayerData.job.grade_name ~= "boss") then return true end
        dst = #(GetEntityCoords(PlayerPedId()) - Config.Boss['pos'])
        if (dst > Config.Boss['markerZone']) then return true end
        msec = 0
        DrawMarker(Config.Markers['id'], Config.Boss['pos'].x, Config.Boss['pos'].y, Config.Boss['pos'].z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, Config.Markers['color'][1], Config.Markers['color'][2], Config.Markers['color'][3], 50, Config.Markers['animate'], true, 2, Config.Markers['turn'], nil, false)
        if (dst > Config.Boss['interactZone']) then
            if (lib.isTextUIOpen()) then lib.hideTextUI() end
            return true 
        end
        if (not lib.isTextUIOpen()) then
            lib.showTextUI(_U('boss_interact'), {position = "left-center"})
        end
        if (IsControlJustPressed(0, 51)) then
            lib.showContext("boss_menu")
        end
        return true
    end) () do
        Wait(msec)
    end
end)

lib.registerContext({
    id = 'boss_menu',
    title = _U('boss_title'),
    options = {
        {
            title = _U('money_cat'),
            onSelect = function(args)
                -- Menu argent
                lib.registerContext({
                    id = 'money_menu',
                    title = _U('money_cat'),
                    options = GetAllMoneyOptions(),
                })
                lib.showContext("money_menu")
            end,
        },
        {
            title = _U('employes_actions'),
            onSelect = function(args)
                -- Menu employé(e)s
                lib.registerContext({
                    id = 'employe_menu',
                    title = _U('employes_actions'),
                    options = GetAllEmployesOptions(),
                })
                lib.showContext("employe_menu")
            end,
        },
        {
            title = _U('recruit_cloest'),
            onSelect = function(args)
                local player, dst = ESX.Game.GetClosestPlayer()
                if (dst ~= 1 and dst <= 2) then
                    ESX.TriggerServerCallback("esx:getOtherPlayerData", function(data) 
                        ESX.TriggerServerCallback("esx_society:setJob", function() end, data.identifier, Config.jobname, 0, "hire")
                    end, GetPlayerServerId(player))
                end
            end
        },
    },
})
