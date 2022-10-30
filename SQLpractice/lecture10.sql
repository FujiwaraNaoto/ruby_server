-- サブクエリで、平均レベル以上userが表示された
SELECT AVG(level) AS 平均レベル FROM users;

SELECT userID, name, level
FROM users
WHERE level >= (SELECT AVG(level) FROM users);



-- 平均レベルの表示
SELECT AVG(level) AS 平均レベル FROM users;

SELECT COUNT(userID) AS 平均レベル以上のユーザ数
FROM users
WHERE level >= (SELECT AVG(level) FROM users);


平均レベルの表示
SELECT AVG(level) AS 平均レベル FROM users;

SELECT COUNT(userID) AS 平均レベル以上のユーザ数,
(SELECT COUNT(*) FROM users) AS 全体のユーザー数
FROM users
WHERE level >= (SELECT AVG(level) FROM users);



-- 平均レベルの表示
SELECT AVG(level) AS 平均レベル FROM users;

SELECT 
    COUNT(userID) AS 平均レベル以上のユーザ数,
    (SELECT COUNT(*) FROM users) AS 全体のユーザー数,
    COUNT(userID)/(SELECT COUNT(*) FROM users)*100 AS 割合
FROM users
WHERE level >= (SELECT AVG(level) FROM users);



FROM句に書く場合

-- FROM句に書く場合
SELECT *
FROM (サブクエリ) AS (サブクエリ名);



WHERE句に書く場合

-- WHERE句に書く場合
SELECT *
FROM users
WHERE level = ((サブクエリ));



SELECT句に書く場合

-- SELECT句に書く場合
SELECT (サブクエリ) AS (サブクエリ名)
FROM users;


逆引きSQL構文集 - 副問合せ(サブクエリ)を行う
http://www.sql-reference.com/select/subquery.html

SQL 副問い合わせの基本を理解する
http://omachizura.com/sql/%E5%89%AF%E5%95%8F%E3%81%84%E5%90%88%E3%82%8F%E3%81%9B%E3%82%92%E7%90%86%E8%A7%A3%E3%81%99%E3%82%8B.html



