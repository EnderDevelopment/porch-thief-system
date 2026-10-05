CREATE TABLE IF NOT EXISTS porch_packages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    x FLOAT NOT NULL,
    y FLOAT NOT NULL,
    z FLOAT NOT NULL,
    health INT NOT NULL,
    reward INT NOT NULL,
    is_spawned BOOLEAN DEFAULT FALSE
);

INSERT INTO porch_packages (model, x, y, z, health, reward, is_spawned) VALUES
('prop_cs_cardbox_01', -1152.1, -1521.9, 4.6, 100, 100, FALSE),
('prop_cs_package_01', -1150.1, -1523.9, 4.6, 100, 150, FALSE);