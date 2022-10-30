*はprimary key
**はforeign key
イベントアクセス記録
eventlog テーブル
- *logID
- **userID
- **eventID
- startTime
- endTime


ユーザ一覧
usersテーブル
- *userID
- name
- **jobID 
- level
- exp
- gold
- deleted_at
- birth
- **areaID

職業一覧
jobs
- *jobID
- job_name

都道府県一覧
area
- *areaID
- area_name

イベント一覧
events
- *eventID
- event_title
- event_state
- event_summary
- event_url
- increase_exp
- increase_gold



chapter1 
-- テーブルを表示
SELECT * FROM users
INNER JOIN jobs ON jobs.jobID=users.jobID
INNER JOIN area ON area.areaID = users.areaID;


-- 書き方のポイント
-- 複数のカラムをカンマで区切る
SELECT userID,name
FROM users
    INNER JOIN jobs ON jobs.jobID = users.jobID
    INNER JOIN area ON area.areaID = users.areaID;


-- 書き方のポイント
-- 複数のカラムをカンマで区切る
-- areaIDはusers テーブル,areaテーブルのどちらにもあるためにエラー
SELECT userID,name,areaID,area_name
FROM users
    INNER JOIN jobs ON jobs.jobID = users.jobID
    INNER JOIN area ON area.areaID = users.areaID;
    

-- 書き方のポイント
-- 複数のカラムをカンマで区切る
-- areaIDはusers テーブル,areaテーブルのどちらにもあるためにエラー
-- areaテーブルのみを指定したいのでarea.areaID
SELECT userID,name,area.areaID,area_name
FROM users
    INNER JOIN jobs ON jobs.jobID = users.jobID
    INNER JOIN area ON area.areaID = users.areaID;
    


-- 書き方のポイント
-- 複数のカラムをカンマで区切る
-- areaIDはusers テーブル,areaテーブルのどちらにもあるためにエラー
-- areaテーブルのみを指定したいのでarea.areaID
-- whereで複数条件指定は ANDで結ぶ
SELECT userID,name,area.areaID,area_name
FROM users
    INNER JOIN jobs ON jobs.jobID = users.jobID
    INNER JOIN area ON area.areaID = users.areaID
WHERE
    userID>=10 
    AND userID<20;


https://paiza.jp/works/aws/primer/aws1

https://paiza.jp/works/aws/primer/aws2

SQL入門編1: SQLの基本文法を学ぶ
https://paiza.jp/works/sql/primer/beginner-sql1

MySQL :: MySQL 5.6 リファレンスマニュアル :: 12.7 日付および時間関数
https://dev.mysql.com/doc/refman/5.6/ja/date-and-time-functions.html



