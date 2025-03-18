function CreateTable()
    local success, err = pcall(function()
        MySQL.query([[CREATE TABLE `yorick-waypoints` (
            `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
            `user_id` INTEGER,
            `x` DOUBLE,
            `y` DOUBLE,
            `z` DOUBLE,
            `description` TEXT,
            `name` VARCHAR(255)
        )]])
    end)

    if not success then
        print("Error creating table: " .. err)
    else
        print("Table created successfully.")
    end
end

CreateThread(CreateTable)
