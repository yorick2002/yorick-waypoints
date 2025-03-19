function CreateWaypointsTable()
    local success, err = pcall(function()
        MySQL.query([[CREATE TABLE IF NOT EXISTS `waypoints` (
            `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
            `x` DOUBLE,
            `y` DOUBLE,
            `z` DOUBLE,
            `description` TEXT,
            `name` VARCHAR(255)
        )]])
    end)

    if not success then
        print("Error creating 'waypoints' table: " .. err)
    else
        print("Table 'waypoints' created or already exists.")
    end
end

function CreateUsersTable()
    local success, err = pcall(function()
        MySQL.query([[CREATE TABLE IF NOT EXISTS `players` (
            `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
            `license2` VARCHAR(255) UNIQUE,
            `playername` VARCHAR(255)
        )]])
    end)

    if not success then
        print("Error creating 'players' table: " .. err)
    else
        print("Table 'players' created or already exists.")
    end
end

-- Call the functions to create the tables
CreateThread(CreateWaypointsTable)
CreateThread(CreateUsersTable)
