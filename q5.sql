USE lab;
DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber;
DROP PROCEDURE IF EXISTS SendWatchTimeReport;
DELIMITER //
CREATE PROCEDURE GetWatchHistoryBySubscriber(IN subID INT)
BEGIN
    SELECT Subscribers.SubscriberName, WatchHistory.ShowID, WatchHistory.WatchTime
    FROM Subscribers
    JOIN WatchHistory 
        ON Subscribers.SubscriberID = WatchHistory.SubscriberID
    WHERE Subscribers.SubscriberID = subID;
END //
CREATE PROCEDURE SendWatchTimeReport()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE sid INT;
    DECLARE cur CURSOR FOR 
        SELECT DISTINCT SubscriberID 
        FROM WatchHistory;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO sid;
        IF done THEN
            LEAVE read_loop;
        END IF;
        CALL GetWatchHistoryBySubscriber(sid);
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
CALL SendWatchTimeReport();
