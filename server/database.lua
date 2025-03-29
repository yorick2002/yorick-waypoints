function CreateTables()
    local success, err = pcall(function()
        MySQL.query([[CREATE TABLE IF NOT EXISTS `yorick_players` (
            `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
            `license2` VARCHAR(255) UNIQUE
        )]])

        MySQL.query([[CREATE TABLE IF NOT EXISTS `yorick_waypoints` (
            `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
            `player_id` INTEGER,
            `x` DOUBLE,
            `y` DOUBLE,
            `z` DOUBLE,
            `description` TEXT,
            `name` VARCHAR(255),
            `favourite` TINYINT DEFAULT 0,
            FOREIGN KEY (`player_id`) REFERENCES `yorick_players`(`id`) ON DELETE CASCADE
        )]])
    end)
end

CreateThread(CreateTables)
