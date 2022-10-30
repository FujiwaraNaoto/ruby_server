-- 月次アクティブユーザー数を求める
-- distinct でプライマリキーであるuserIDの重複を許さないようにしている
SELECT yearMonth,COUNT(user)
FROM (
SELECT DISTINCT
	DATE_FORMAT(startTime, '%Y-%m') AS yearMonth,
	eventlog.userID AS user
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
WHERE deleted_at IS NULL) AS Num_count
GROUP BY yearMonth;





-- 本質は同じだけど, COUNTをcountとするとエラーになる
-- これでもOK
SELECT yearMonth,COUNT(user)
FROM(
    SELECT DISTINCT DATE_FORMAT(startTIme,'%Y-%m') AS yearMonth,users.userID AS user
    FROM users
    INNER JOIN eventlog ON eventlog.userID = users.userID
    WHERE users.deleted_at IS NULL 
) AS tmptable
GROUP BY yearMonth;