-- アクティブユーザーを求める
-- カラム名の別名をASで指定
SELECT COUNT(*) AS 'the number of active users' FROM users;


-- アクティブユーザーを求める
-- カラム名の別名
-- 退会した際にdeleted_atに時刻が入る　退会していない場合はNULL
SELECT COUNT(*) AS 'the number of active users' 
FROM users
WHERE deleted_at IS NULL;


-- イベントログにあるユーザIDが重複無しで処理
SELECT DISTINCT userID AS 'the number of active users' 
FROM eventlog;



-- 登録が残っている(空のカラム行を表示する IS NULL)ユーザIDのみが表示される
SELECT DISTINCT eventlog.userID AS 'the number of active users' 
FROM eventlog
    INNER JOIN users ON users.userID=eventlog.userID
WHERE deleted_at IS NULL;



-- 登録が残っているユーザIDのみが表示される
-- 重複行を一つにまとめてから集計を行うようにする
SELECT  COUNT(DISTINCT eventlog.userID) AS 'the number of active users' 
FROM eventlog
    INNER JOIN users ON users.userID=eventlog.userID
WHERE deleted_at IS NULL;


-- 日付でグループ化して,アクセス日ごとのユーザ数を重複しないようにカウント
SELECT  
    DATE(eventlog.startTime) AS 'date',
    COUNT(DISTINCT eventlog.userID) AS 'the number of active users' 
FROM eventlog
    INNER JOIN users ON users.userID=eventlog.userID
WHERE deleted_at IS NULL
GROUP BY DATE(eventlog.startTime);


逆引きSQL構文集 - 検索結果の列名を別名で表示する
http://www.sql-reference.com/select/as.html

逆引きSQL構文集 - 重複したレコードを省いて検索する
http://www.sql-reference.com/select/distinct.html

逆引きSQL構文集 - NULL値を持つデータを検索する
http://www.sql-reference.com/select/is_null.html