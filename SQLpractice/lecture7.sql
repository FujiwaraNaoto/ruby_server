サブクエリでは クエリ結果を新たな　クエリに入れることができる.


-- サブクエリで、アクティブユーザー数を求める
-- DISTINCT 重複しないユーザID(プライマリキー)を取り出す
-- かつ,退会していないユーザ 
SELECT DISTINCT
	DATE(startTime) AS day,
	eventlog.userID AS user
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
WHERE deleted_at IS NULL;



-- DISTINCT *のなかで重複しない値達の組を取り出す
-- かつ,退会していないユーザ 
-- 外側のSQLでは,サブクエリで受け取ったデータをそのまま利用している
SELECT * 
FROM ( SELECT DISTINCT
	DATE(startTime) AS day,
	eventlog.userID AS user
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
WHERE deleted_at IS NULL)
AS ActiveUsers;


-- サブクエリで、アクティブユーザー数を求める
-- DISTINCT 重複しないユーザID(プライマリキー)を取り出す
-- かつ,退会していないユーザ 
-- dayが同じ者をまとめて,user数を数える
-- サブクエリ中のdayカラムをグループにまとめている
SELECT day,COUNT(user)
FROM (SELECT DISTINCT
	DATE(startTime) AS day,
	eventlog.userID AS user
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
WHERE deleted_at IS NULL) AS ActiveUsers
GROUP BY day;



-- FROM句に書く場合
SELECT *
FROM (サブクエリ) AS (サブクエリ名);

逆引きSQL構文集 - 副問合せ(サブクエリ)を行う
http://www.sql-reference.com/select/subquery.html

SQL 副問い合わせの基本を理解する
http://omachizura.com/sql/%E5%89%AF%E5%95%8F%E3%81%84%E5%90%88%E3%82%8F%E3%81%9B%E3%82%92%E7%90%86%E8%A7%A3%E3%81%99%E3%82%8B.html


