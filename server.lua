local ESX = nil
local spawnedPackages = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.PackageSpawnInterval)
        spawnPackages()
    end
end)

function spawnPackages()
    MySQL.Async.fetchAll('SELECT * FROM porch_packages WHERE is_spawned = FALSE', {}, function(result)
        if #result > 0 then
            local packageData = result[1]
            MySQL.Async.execute('UPDATE porch_packages SET is_spawned = TRUE WHERE id = @id', {['@id'] = packageData.id}, function()
                TriggerClientEvent('porchthief:spawnPackage', -1, packageData)
                table.insert(spawnedPackages, packageData)
            end)
        end
    end)
end

RegisterServerEvent('porchthief:robPackage')
AddEventHandler('porchthief:robPackage', function(netId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local packageData = nil

    for i, package in ipairs(spawnedPackages) do
        if package.netId == netId then
            packageData = package
            table.remove(spawnedPackages, i)
            break
        end
    end

    if packageData then
        MySQL.Async.execute('UPDATE porch_packages SET is_spawned = FALSE WHERE id = @id', {['@id'] = packageData.id}, function()
            local reward = math.random(packageData.reward_min, packageData.reward_max)
            xPlayer.addMoney(reward)
            TriggerClientEvent('porchthief:removePackage', -1, netId)
            TriggerClientEvent('esx:showNotification', source, 'You robbed the package and received ~g~$' .. reward)
        end)
    end
end)