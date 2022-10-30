-- 平均以上の所持金を持つユーザー数を表示する
SELECT userID, name, gold
FROM users
WHERE gold>=(SELECT AVG(gold) FROM users);



-- サブクエリ無しver
-- ユーザーの平均年齢を求める
SELECT
	SUM(TIMESTAMPDIFF(YEAR, birth, '2017-01-01')) AS '年齢の合計',
    COUNT(*) AS 'ユーザー数',
    AVG(TIMESTAMPDIFF(YEAR, birth, '2017-01-01')) AS '平均年齢'
FROM
	users

--模範解答
-- ユーザーの平均年齢を求める
SELECT
	SUM(TIMESTAMPDIFF(YEAR, birth, '2017-01-01')) AS '年齢の合計',
	COUNT(*) AS 'ユーザー数',
	SUM(TIMESTAMPDIFF(YEAR, birth, '2017-01-01')) / COUNT(*) AS '平均年齢'
FROM
	users;