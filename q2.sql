-- Step 1: Ensure correct DB
USE lab;
-- Step 2: Drop any old procedure just in case
DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber;
-- Step 3: Create it
DELIMITER //
CREATE PROCEDURE GetWatchHistoryBySubscriber(IN p_SubscriberID INT)
BEGIN
    SELECT WatchHistory.WatchTime, Shows.ShowID
    FROM WatchHistory
    JOIN Shows 
        ON WatchHistory.ShowID = Shows.ShowID
    WHERE WatchHistory.SubscriberID = p_SubscriberID;
END //
DELIMITER ;
-- Step 4: Confirm it exists
SHOW PROCEDURE STATUS WHERE Db = 'lab';
-- Step 5: Call it
CALL GetWatchHistoryBySubscriber(1);
