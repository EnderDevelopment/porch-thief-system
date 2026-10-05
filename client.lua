local ESX = nil
local spawnedPackages = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for _, package in pairs(spawnedPackages) do
            local packageCoords = GetEntityCoords(package)
            local distance = #(playerCoords - packageCoords)

            if distance < 2.0 then
                DrawText3D(packageCoords.x, packageCoords.y, packageCoords.z + 0.5, "Press E to rob the package")

                if IsControlJustPressed(0, 38) then
                    TriggerServerEvent('porchthief:robPackage', VehToNet(package))
                end
            end
        end
    end
end)

RegisterNetEvent('porchthief:spawnPackage')
AddEventHandler('porchthief:spawnPackage', function(packageData)
    local model = GetHashKey(packageData.model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    local package = CreateObject(model, packageData.x, packageData.y, packageData.z, false, false, true)
    SetEntityHeading(package, packageData.heading)
    SetEntityAsMissionEntity(package, true, true)
    table.insert(spawnedPackages, package)
end)

RegisterNetEvent('porchthief:removePackage')
AddEventHandler('porchthief:removePackage', function(netId)
    for i, package in ipairs(spawnedPackages) do
        if VehToNet(package) == netId then
            DeleteEntity(package)
            table.remove(spawnedPackages, i)
            break
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end