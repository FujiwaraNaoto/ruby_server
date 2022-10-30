-- ユーザーごとの合計獲得金額と平均獲得金額
SELECT
	eventlog.userID AS "ユーザーID",
	SUM(events.increase_gold) AS "合計",
	AVG(events.increase_gold) AS "平均"
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
GROUP BY eventlog.userID
HAVING SUM(events.increase_gold)>=50
ORDER BY eventlog.userID;


-- レベルごとの平均経験値と平均ゴールド
SELECT level, AVG(exp), AVG(gold)
FROM users
GROUP BY users.level
ORDER BY level;
