-- いろいろな集計
-- ユーザごとに得点の総和をとる
SELECT
	eventlog.userID AS ユーザーID,
	SUM(events.increase_exp) AS 合計
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
GROUP BY eventlog.userID;


-- いろいろな集計
-- userごとに獲得経験値の平均が集計される
SELECT
	eventlog.userID AS ユーザーID,
	SUM(events.increase_exp) AS 合計,
	AVG(events.increase_exp) AS 平均
	
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
GROUP BY eventlog.userID;



-- いろいろな集計
-- userごとに獲得経験値の平均が集計される
-- 獲得経験値が3000以上のユーザの情報が表示される
-- Havingは Group Byの後に記述
- 1. FROM 対象テーブルからデータを取り出す
- 2. WHERE 条件に一致するレコードを絞り込み
- 3. GROUP BY グループ化
- 4. HAVING 集計結果から絞り込み
- 5. SELECT 指定したカラムだけを表示

SELECT
	eventlog.userID AS ユーザーID,
	SUM(events.increase_exp) AS 合計,
	AVG(events.increase_exp) AS 平均
	
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
GROUP BY eventlog.userID
    HAVING SUM(events.increase_exp)>=3000;



-- いろいろな集計
-- userごとに獲得経験値の平均が集計される
-- userID 各イベントの開始時刻と終了時刻
SELECT
	eventlog.userID AS ユーザーID,
    startTime,
    endTime
FROM
	eventlog


SELECT
	eventlog.userID AS ユーザーID,
    MIN(startTime) AS 開始日,
    MAX(endTime) AS 終了日
FROM
	eventlog
GROUP BY eventlog.userID;







