USE lab;
DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists;
DELIMITER $$
CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
    DECLARE cnt INT DEFAULT 0;
    DECLARE nextId INT DEFAULT 0;
    -- Check if subscriber already exists (case-insensitive)
    SELECT COUNT(*) INTO cnt
    FROM Subscribers
    WHERE LOWER(SubscriberName) = LOWER(subName);
    IF cnt = 0 THEN
        -- Get next SubscriberID
        SELECT IFNULL(MAX(SubscriberID), 0) + 1 INTO nextId
        FROM Subscribers;
        -- Insert new subscriber with ID and current date
        INSERT INTO Subscribers (SubscriberID, SubscriberName, SubscriptionDate)
        VALUES (nextId, subName, CURDATE());
        SELECT CONCAT('Subscriber "', subName, '" added successfully.') AS Message;
    ELSE
        SELECT CONCAT('Subscriber "', subName, '" already exists.') AS Message;
    END IF;
END$$
DELIMITER ;
-- Test call
CALL AddSubscriberIfNotExists('Sujata Shiekh Peterson');
