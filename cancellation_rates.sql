-- From the following table of user IDs, actions, and dates, write a query to return the publication and cancellation rate for each user.

CREATE TABLE users (user_id, "action", date) 
AS (VALUES 
(1,'start', CAST('01-01-20' AS date)), 
(1,'cancel', CAST('01-02-20' AS date)), 
(2,'start', CAST('01-03-20' AS date)), 
(2,'publish', CAST('01-04-20' AS date)), 
(3,'start', CAST('01-05-20' AS date)), 
(3,'cancel', CAST('01-06-20' AS date)), 
(1,'start', CAST('01-07-20' AS date)), 
(1,'publish', CAST('01-08-20' AS date)));

CREATE VIEW results AS
SELECT user_id, 
    sum(CASE WHEN ACTION = 'start' THEN 1 ELSE 0 END) AS starts,
    sum(CASE WHEN ACTION = 'publish' THEN 1 ELSE 0 END) AS publishes,
    sum(CASE WHEN ACTION = 'cancel' THEN 1 ELSE 0 END) AS cancels
FROM users
GROUP BY user_id
ORDER BY user_id ASC;

SELECT * FROM results;

SELECT user_id, 
    1.0 * publishes / starts AS pub, 
    1.0 * cancels / starts AS canc
FROM results
GROUP BY user_id, publishes, cancels, starts
ORDER BY user_id;
