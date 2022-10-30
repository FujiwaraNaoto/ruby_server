
-- 日付に関する計算
-- プレイ時間を計算させる
SELECT
	userID AS ユーザーID,
	MIN(startTime) AS 開始日,
	MAX(endTime) AS 終了日,
	DATE(MAX(endTime))-DATE(MIN(startTime))+1 AS プレイ期間
FROM
	eventlog
GROUP BY userID;


-- 日付に関する計算
-- ユーザIDと生年月日の表示
SELECT
	userID AS ユーザーID,
    birth AS 生年月日 
FROM
    users;


-- 日付に関する計算
-- ユーザIDと生年月日の表示
-- 現在の年の表示
--　数え年(誕生日が来る前に年齢が上がる)
SELECT
	userID AS ユーザーID,
	YEAR(CURRENT_DATE()) AS 現在年,
    birth AS 生年月日,
    YEAR(CURRENT_DATE)-YEAR(birth) AS 数え年
FROM
    users;


-- 万年齢を計算させる
SELECT
	userID AS ユーザーID,
	YEAR(CURRENT_DATE()) AS 現在年,
    birth AS 生年月日,
    TIMESTAMPDIFF(YEAR,birth,CURRENT_DATE()) AS 満年齢
FROM
    users;



現在の日時を求める
CURRENT_DATE()) AS 現在日時


2つの日時の間の期間を整数で求める
TIMESTAMPDIFF(YEAR, (誕生日), (現在の日時))



逆引きSQL構文集 - 四則演算を行う
http://www.sql-reference.com/math/operatore.html

【MySQL】日付時刻関数を使用して、日付や時刻の差分を取得する | バシャログ。
http://bashalog.c-brains.jp/14/02/28-150000.php

mysqlで年齢計算 - Qiita
http://qiita.com/kabayama/items/b5775e6904c7a4d627a8

MySQL :: MySQL 5.6 リファレンスマニュアル :: 12.7 日付および時間関数
https://dev.mysql.com/doc/refman/5.6/ja/date-and-time-functions.html



