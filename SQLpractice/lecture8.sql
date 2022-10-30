-- データを分類し直す
-- CASEに該当する新たな列 クラス　が追加されていることがわかる
-- 条件式は上から判断される
SELECT
	userID,
	level,
	CASE 
	    WHEN level>=4 THEN '上級'
	    WHEN level>=2 THEN '中級'
	    ELSE '初級'
	END AS クラス
FROM
	users;


-- データを分類し直す
-- CASEに該当する新たな列 クラス　が追加されていることがわかる
-- CASEで新たなviewが作られるので,それに対しての処理が行われる
SELECT
	CASE 
	    WHEN level>=4 THEN '上級'
	    WHEN level>=2 THEN '中級'
	    ELSE '初級'
	END AS クラス,COUNT(*) AS ユーザー数
FROM
	users
GROUP BY クラス;




