-- From the following table of transactions between two users, 
-- write a query to return the change in net worth for each user, 
-- ordered by decreasing net change.


CREATE TABLE transactions (sender, receiver, amount, transaction_date) 
AS (VALUES 
(5, 2, 10, CAST('2-12-20' AS date)),
(1, 3, 15, CAST('2-13-20' AS date)), 
(2, 1, 20, CAST('2-13-20' AS date)), 
(2, 3, 25, CAST('2-14-20' AS date)), 
(3, 1, 20, CAST('2-15-20' AS date)), 
(3, 2, 15, CAST('2-15-20' AS date)), 
(1, 4, 5, CAST('2-16-20' AS date)));

CREATE VIEW send AS
SELECT sender, sum(amount) AS sendings
FROM transactions
GROUP BY sender;

CREATE VIEW receive AS
SELECT receiver, sum(amount) AS receivings
FROM transactions
GROUP BY receiver;

SELECT COALESCE(s.sender, r.receiver) AS "user", COALESCE(r.receivings, 0) - COALESCE(s.sendings, 0) AS net_amount
FROM send AS s
FULL JOIN receive AS r ON s.sender = r.receiver
ORDER BY net_amount DESC