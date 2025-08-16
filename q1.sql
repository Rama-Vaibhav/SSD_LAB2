use lab;
DELIMITER //
CREATE PROCEDURE ListAllSubscribers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE sub_name VARCHAR(100);
    -- Declare cursor
    DECLARE cur CURSOR FOR 
        SELECT SubscriberName FROM Subscribers;
    -- Handler for when cursor is done reading
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO sub_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Output subscriber name
        SELECT sub_name AS SubscriberName;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
-- Call the procedure
CALL ListAllSubscribers();
