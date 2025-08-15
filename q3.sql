USE lab;
DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists;
use lab;
DELIMITER //
CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    -- Check if the subscriber already exists (case-insensitive)
    IF EXISTS (
        SELECT 1 
        FROM Subscribers
        WHERE LOWER( SubscriberName) = LOWER(subName)
    ) THEN
        SELECT CONCAT('Subscriber "', subName, '" already exists.') AS Message;
    ELSE
        INSERT INTO Subscribers ( SubscriberName)
        VALUES (subName);
        SELECT CONCAT('Subscriber "', subName, '" added successfully.') AS Message;
    END IF;
END //
DELIMITER ;

CALL AddSubscriberIfNotExists('John Doe');
