USE lab;
DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber;
DROP PROCEDURE IF EXISTS SendWatchTimeReport;
DELIMITER //
CREATE PROCEDURE GetWatchHistoryBySubscriber()
BEGIN
    SELECT s.SubscriberID, s.Name, w.WatchTime, sh.ShowID
    FROM Subscribers s
    JOIN WatchHistory w ON s.SubscriberID = w.SubscriberID
    JOIN Shows sh ON w.ShowID = sh.ShowID; 
    -- now this gives the only thing which we have seen subscriber who has watchtime along with it the show  
END //
CREATE PROCEDURE SendWatchTimeReport()
BEGIN
    CALL GetWatchHistoryBySubscriber();
END //
DELIMITER ;
