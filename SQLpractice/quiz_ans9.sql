-- 所持金で分類してクロス集計
SELECT
	日付,
	finance
FROM ( SELECT DISTINCT
	DATE_FORMAT(startTime, '%Y%m') AS 日付,
	eventlog.userID,
	(CASE
		WHEN gold >= 3000 THEN "大金持ち"
		WHEN gold >= 1000 THEN "小金持ち"
		ELSE "発展途上"
	END) AS finance
	FROM eventlog
		INNER JOIN users ON users.userID = eventlog.userID
	) AS クラス分け











-- 所持金で分類してクロス集計
-- 日付でグループ化するところがポイント
SELECT
	日付,
	SUM(CASE WHEN finance="大金持ち" THEN 1 ELSE 0 END) AS "大金持ち",
    SUM(CASE WHEN finance="小金持ち" THEN 1 ELSE 0 END) AS "小金持ち",
    SUM(CASE WHEN finance="発展途上" THEN 1 ELSE 0 END) AS "発展途上"
    FROM (SELECT DISTINCT
    	DATE_FORMAT(startTime, '%Y%m') AS 日付,
    	eventlog.userID,
    	(CASE
    		WHEN gold >= 3000 THEN "大金持ち"
    		WHEN gold >= 1000 THEN "小金持ち"
    		ELSE "発展途上"
    	END) AS finance
    	FROM eventlog
    		INNER JOIN users ON users.userID = eventlog.userID
    ) AS クラス分け
    GROUP BY 日付



-- 手を加える前の最初の状態を実行するとエラー
SELECT DISTINCT DATE_FORMAT(startTime,"%Y%m") AS 日付
    (CASE
    WHEN gold >=3000 THEN "大金持ち"
    WHEN gold >=1000 THEN "小金持ち"
    ELSE "発展途上" END
    )AS finance
FROM users
    INNER JOIN eventlog ON eventlog.userID = users.userID;
    
