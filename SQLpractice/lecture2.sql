-- 日次・月次のアクセス数を求める
SELECT DATE(startTime),logID 
FROM eventlog;



groupbyで日付ずつにまとめて, countで行数をカウント
-- 日次・月次のアクセス数を求める
SELECT DATE(startTime),COUNT(logID)
FROM eventlog
GROUP BY(DATE(startTime));



-- 日次・月次のアクセス数を求める
-- 4月以降のアクセス数の表示
SELECT DATE(startTime),COUNT(logID)
FROM eventlog WHERE DATE(startTime)>='2015-04-01'
GROUP BY(DATE(startTime));


-- 4月のアクセス数の表示
-- 日次・月次のアクセス数を求める
SELECT DATE(startTime),COUNT(logID)
FROM eventlog 
WHERE DATE(startTime) BETWEEN '2015-04-01' AND '2015-04-30'
GROUP BY(DATE(startTime));


-- 日次・月次のアクセス数を求める
-- 月別アクセス数の表示
SELECT DATE_FORMAT(startTime,'%Y-%m'),COUNT(logID)
FROM eventlog
GROUP BY DATE_FORMAT(startTime,'%Y-%m');
