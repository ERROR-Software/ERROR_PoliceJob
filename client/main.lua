RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    ESX.PlayerData = playerData
end)

RegisterNetEvent("esx:setJob", function(job)
    ESX.PlayerData.job = job
end)

function SpawnNpc(model, x, y, z, h)
    model = GetHashKey(model)
    RequestModel(model)
    while (not HasModelLoaded(model)) do Wait(0) end
    local npc = CreatePed(6, model, x, y, z-1, h, false, false)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    return {model = npc, coords = vec3(x, y, z)}
end

function CreateBlip(name, color, sprite, x, y, z)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, sprite)
    SetBlipScale(blip, 1.0)
    SetBlipDisplay(blip, 4)
    SetBlipColour(blip, color)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
end

RegisterCommand("cp", function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    lib.setClipboard(("vec4(%s,%s,%s,%s)"):format(x, y, z, GetEntityHeading(PlayerPedId())))
end)

function PlayAnim(ped, animDict, animName, duration, body)
    ESX.Streaming.RequestAnimDict(animDict)
    duration = duration or (math.floor(GetAnimDuration(animDict, animName))-1)*1000
    TaskPlayAnim(ped, animDict, animName, 8.0, 8.0, duration, body and 49 or 1, 0, false, false, false);
    if (duration ~= -1) then
        Wait(duration)
    end
end

function CreateCameraa(x, y, z, w, rotX)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, x, y, z)
    SetCamActive(cam, true)
    SetCamRot(cam, rotX, 0.0, w, 2) -- Utilisez heading comme rotation Z
    RenderScriptCams(true, false, 0, true, false)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
    FreezeEntityPosition(PlayerPedId(), true)
    return cam
end

function DestroyCamm(cam)
    if (not ESX.PlayerData.job or ESX.PlayerData.job.name ~= Config.jobname) then return false end
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(false, false, 0, false, false)
    NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityCoords(PlayerPedId(), last_coords)
    cam = nil
end