Config = {}

-- Package spawn settings
Config.PackageSpawnInterval = 300000 -- 5 minutes in milliseconds
Config.PackageSpawnRadius = 50.0 -- Radius around doors to spawn packages

-- Package settings
Config.PackageModels = {
    'prop_cs_cardbox_01',
    'prop_cs_package_01'
}
Config.PackageHealth = 100
Config.PackageReward = {min = 50, max = 200}

-- Door settings
Config.Doors = {
    {x = -1152.1, y = -1521.9, z = 4.6, heading = 30.0},
    {x = -1150.1, y = -1523.9, z = 4.6, heading = 30.0}
}