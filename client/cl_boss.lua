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
            icon = 'fa-solid fa-money-bill-wave',
            disabled = true
        },
        {
            title = _U('deposit_money'),
            icon = 'fa-solid fa-circle-arrow-down',
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
            icon = 'fa-solid fa-circle-arrow-up',
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
                        menu = "boss_menu",
                        options = {
                            {
                                title = _U('promote'),
                                icon = 'fa-solid fa-arrow-up',
                                onSelect = function()
                                    if (employe.job.grade < Config.MaxPoliceGrades and employe.identifier ~= ESX.PlayerData.identifier) then
                                        return ESX.TriggerServerCallback("esx_society:setJob", function() end, employe.identifier, Config.jobname, employe.job.grade+1, 'promote')
                                    end
                                    ESX.ShowNotification(_U('promote_error'), "error")
                                end
                            },
                            {
                                title = _U('fire'),
                                icon = 'fa-solid fa-user-xmark',
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
                                icon = 'fa-solid fa-arrow-down',
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

local function ShowEditLockerMenu(lockerCode)
    lib.registerContext({
        id = 'edit_locker_menu',
        title = _U('edit_locker_title', lockerCode),
        menu = "locker_menu",
        options = {
            {
                title = _U('edit_locker_code', lockerCode),
                icon = 'fa-solid fa-pen',
                onSelect = function()
                    local input = lib.inputDialog(_U('edit_locker_code'), {
                        { type = 'number', label = _U('locker_code_new'), required = true, min = 1 }
                    })
                    if not input or not input[1] then return end
                    local newCode = input[1]
                    TriggerServerEvent("ERROR_PoliceJob:ModifyLocker", "update_code", lockerCode, newCode)
                    ESX.ShowNotification(_U('locker_code_updated'), "success")
                end
            },
            {
                title = _U('edit_locker_passwd'),
                icon = 'fa-solid fa-key',
                onSelect = function()
                    local input = lib.inputDialog(_U('edit_locker_passwd'), {
                        { type = 'input', label = _U('locker_passwd_new'), required = true, password = true }
                    })
                    if not input or not input[1] then return end
                    local newPass = input[1]
                    TriggerServerEvent("ERROR_PoliceJob:ModifyLocker", "update_passwd", lockerCode, nil, newPass)
                    ESX.ShowNotification(_U('locker_passwd_updated'), "success")
                end
            },

            {
                title = _U('delete_locker'),
                icon = 'fa-solid fa-trash',
                onSelect = function()
                    local confirm = lib.inputDialog(_U('delete_locker_confirm', lockerCode), {
                        { type = 'checkbox', label = _U('confirm_delete'), required = true }
                    })
                    if not confirm or not confirm[1] then return end
                    TriggerServerEvent("ERROR_PoliceJob:ModifyLocker", "delete", lockerCode)
                    ESX.ShowNotification(_U('locker_deleted'), "success")
                end
            }
        }
    })
    lib.showContext("edit_locker_menu")
end

local function GetLockerOptions()
    local options = {
        {
            title = _U('create_locker'),
            icon = 'fa-solid fa-plus',
            onSelect = function()
                local input = lib.inputDialog(_U('create_locker'), {
                    { type = 'number', label = _U('locker_code'), required = true, min = 1},
                    { type = 'input', label = _U('locker_passwd'), required = true, password = true}
                })
                if not input or not input[1] or not input[2] then
                    return
                end

                local lockerCode = input[1]
                local lockerPassword = input[2]
                TriggerServerEvent("ERROR_PoliceJob:createLocker", lockerCode, lockerPassword)
                ESX.ShowNotification(_U('locker_created'), "success")
            end
        },
        {
            title = _U('delete_locker'),
            icon = 'fa-solid fa-trash',
            onSelect = function()
                local input = lib.inputDialog(_U('delete_locker'), {
                    { type = 'number', label = _U('locker_code'), required = true, min = 1 },
                })
                if not input or not input[1] then
                    return
                end

                local lockerCode = input[1]
                TriggerServerEvent("ERROR_PoliceJob:ModifyLocker", "delete", lockerCode)
            end
        },
    }

    ESX.TriggerServerCallback("ERROR_PoliceJob:ListLockers", function(lockers)
        if lockers and #lockers > 0 then
            for _, code in ipairs(lockers) do
                table.insert(options, {
                    title = _U('locker_entry', code),
                    icon = 'fa-solid fa-lock',
                    onSelect = function()
                        ShowEditLockerMenu(code)
                    end
                })
            end
        end
    end)

    local timeout = 0
    while not options or #options <= 2 do
        Wait(0)
        timeout = timeout + 1
        if timeout > 100 then break end
    end

    return options
end

local function ShowLockerMenu()
    lib.registerContext({
        id = 'locker_menu',
        title = _U('locker_actions'),
        options = GetLockerOptions(),
        menu = "boss_menu",
    })
    lib.showContext("locker_menu")
end

exports.ox_target:addBoxZone({
    coords = Config.Boss['pos'],
    size = vec3(1.5, 1.5, 2.0),
    rotation = 0,
    debug = Config.Debug,
    drawSprite = true,
    options = {
        {
            name = 'boss_menu',
            icon = 'fa-solid fa-user-tie',
            label = _U('boss_interact'),
            distance = 2.0,
            onSelect = function(data)
                lib.showContext("boss_menu")
            end,

            canInteract = function(entity, distance, coords, name)
                return ESX.PlayerData.job and ESX.PlayerData.job.name == Config.jobname and ESX.PlayerData.job.grade_name == "boss"
            end
        }
    }
})

lib.registerContext({
    id = 'boss_menu',
    title = _U('boss_title'),
    options = {
        {
            title = _U('locker_actions'),
            icon = 'fa-solid fa-box-archive',
            onSelect = function(args)
                ShowLockerMenu()
            end,
        },
        {
            title = _U('money_cat'),
            icon = 'fa-solid fa-sack-dollar',
            onSelect = function(args)
                -- Menu argent
                lib.registerContext({
                    id = 'money_menu',
                    title = _U('money_cat'),
                    menu = "boss_menu",
                    options = GetAllMoneyOptions(),
                })
                lib.showContext("money_menu")
            end,
        },
        {
            title = _U('employes_actions'),
            icon = 'fa-solid fa-users',
            onSelect = function(args)
                -- Menu employé(e)s
                lib.registerContext({
                    id = 'employe_menu',
                    title = _U('employes_actions'),
                    menu = "boss_menu",
                    options = GetAllEmployesOptions(),
                })
                lib.showContext("employe_menu")
            end,
        },
        {
            title = _U('recruit_cloest'),
            icon = 'fa-solid fa-user-plus',
            menu = "boss_menu",
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
