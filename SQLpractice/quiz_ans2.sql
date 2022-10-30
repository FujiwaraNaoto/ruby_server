
-- 日次のアクセス数を求める
SELECT DATE(startTime), COUNT(logID)
FROM eventlog
GROUP BY (DATE(startTime))


-- 3月の日次アクセス数を求める
-- 3月の最初の7日間('2015-03-01'から'2015-03-07'の期間)の日次アクセス数を表示
SELECT DATE(startTime), COUNT(logID)
FROM eventlog
WHERE DATE(startTime) BETWEEN '2015-03-01' AND '2015-03-07'
GROUP BY DATE(startTime);


-- 月次のアクセス数を求める
SELECT DATE_FORMAT(startTime, '%Y-%m'),COUNT(logID)
FROM eventlog
GROUP BY DATE_FORMAT(startTime,'%Y-%m');