
-- ユーザーの平均年齢を求める
SELECT
	AVG(TIMESTAMPDIFF(YEAR, birth, '2016-12-01')) AS '平均年齢'
FROM
	users;


