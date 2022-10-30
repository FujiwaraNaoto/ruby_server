-- テキスト検索
-- 誰が,いつ,どのイベントに参加したか
SELECT
	userID,
	startTime,
	events.event_summary
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID;


-- テキスト検索
-- 誰が,いつ,どのイベントに参加したか
-- システムイベントはeventsテーブルのevent_stage=0
-- 0以外のイベントが表示される.
-- userIDで並べて,そのなかでstartTImeで並べる
SELECT
	userID,
	startTime,
	events.event_summary
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
WHERE events.event_stage<>0
ORDER BY 
    userID,startTime;



-- テキスト検索
-- 誰が,いつ,どのイベントに参加したか
-- システムイベントはeventsテーブルのevent_stage=0
-- 0以外のイベントが表示される.
-- userIDで並べて,そのなかでstartTImeで並べる
-- hogehogeとの戦い
SELECT
	userID,
	startTime,
	events.event_summary
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
WHERE events.event_stage<>0
    AND events.event_summary LIKE '%との闘い'
ORDER BY 
    userID,startTime;



-- テキスト検索
-- 誰が,いつ,どのイベントに参加したか
-- システムイベントはeventsテーブルのevent_stage=0
-- 0以外のイベントが表示される.
-- userIDで並べて,そのなかでstartTImeで並べる
-- hogehogeとの戦い %は0文字以上の任意の文字列
-- event_urlにdungeonというキーワードが含まれている者を取り出す
SELECT
	userID,
	startTime,
	events.event_summary,
	events.event_url
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
WHERE events.event_stage<>0
     AND events.event_url LIKE '%dungeon%'
ORDER BY 
    userID,startTime;



-- テキスト検索
SELECT
	events.event_summary
FROM
	eventlog
	INNER JOIN events ON events.eventID = eventlog.eventID
WHERE  events.event_summary LIKE '%との闘い'



逆引きSQL構文集 - ワイルドカードを使用してレコードを検索する
http://www.sql-reference.com/select/like.html


