-- クロス集計をつくる前
SELECT
	startTime,
	eventlog.userID,
	users.level
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID;



-- クロス集計をつくる前
-- 重複ありver
SELECT 
	DATE_FORMAT(startTime,'%Y-%m') AS 日付,
	eventlog.userID AS ユーザー,
	CASE 
	    WHEN users.level>=4 THEN '上級'
	    WHEN users.level>=2 THEN '中級'
	    ELSE '初級'
	END AS クラス,
	users.level
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID;


-- クロス集計
-- DISTINCTで (日付,ユーザー,クラス)の組が重複しない者を返す
SELECT DISTINCT
	DATE_FORMAT(startTime,'%Y-%m') AS 日付,
	eventlog.userID AS ユーザー,
	CASE 
	    WHEN users.level>=4 THEN '上級'
	    WHEN users.level>=2 THEN '中級'
	    ELSE '初級'
	END AS クラス
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID;


-- クロス集計
-- DISTINCTで (日付,ユーザー,クラス)の組が重複しない者を返す
SELECT 
    日付,
    ユーザー,
    クラス
FROM (SELECT DISTINCT
	DATE_FORMAT(startTime,'%Y-%m') AS 日付,
	eventlog.userID AS ユーザー,
	CASE 
	    WHEN users.level>=4 THEN '上級'
	    WHEN users.level>=2 THEN '中級'
	    ELSE '初級'
	END AS クラス
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
) AS クラス分け;


-- クロス集計
-- DISTINCTで (日付,ユーザー,クラス)の組が重複しない者を返す
-- クラスが初級なら1に置き換えるカラムを追加
SELECT 
    日付,
    ユーザー,
    クラス,
    CASE WHEN クラス='初級' THEN 1 ELSE 0 END AS '初級',
    CASE WHEN クラス='中級' THEN 1 ELSE 0 END AS '中級',
    CASE WHEN クラス='上級' THEN 1 ELSE 0 END AS '上級'
FROM (SELECT DISTINCT
	DATE_FORMAT(startTime,'%Y-%m') AS 日付,
	eventlog.userID AS ユーザー,
	CASE 
	    WHEN users.level>=4 THEN '上級'
	    WHEN users.level>=2 THEN '中級'
	    ELSE '初級'
	END AS クラス
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
) AS クラス分け;



1. クロス集計の元になるデータを用意する
2. サブクエリとして読み込む
3. CASEで、特定の値だったら1にする。このとき別名を、特定の値と同じにする

CASE WHEN クラス = "初級" THEN 1 ELSE NULL END AS "初級",
CASE WHEN クラス = "中級" THEN 1 ELSE NULL END AS "中級",
CASE WHEN クラス = "上級" THEN 1 ELSE NULL END AS "上級"

4. SUM関数とGROUP BYで集計する


-- クロス集計
-- DISTINCTで (日付,ユーザー,クラス)の組が重複しない者を返す
-- クラスが初級なら1に置き換えるカラムを追加
-- 月別とクラス別のクロス集計表ができた.
SELECT 
    日付,
    SUM(CASE WHEN クラス='初級' THEN 1 ELSE 0 END) AS '初級',
    SUM(CASE WHEN クラス='中級' THEN 1 ELSE 0 END) AS '中級',
    SUM(CASE WHEN クラス='上級' THEN 1 ELSE 0 END) AS '上級'
FROM (SELECT DISTINCT
	DATE_FORMAT(startTime,'%Y-%m') AS 日付,
	eventlog.userID AS ユーザー,
	CASE 
	    WHEN users.level>=4 THEN '上級'
	    WHEN users.level>=2 THEN '中級'
	    ELSE '初級'
	END AS クラス
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
) AS クラス分け
GROUP BY 日付;


MySQLでクロス集計してみた | トーハム紀行
http://torhamzedd.blogspot.jp/2010/06/mysql.html

