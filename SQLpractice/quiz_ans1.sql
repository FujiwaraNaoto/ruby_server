

-- logIDが10以下のイベントログを表示
SELECT * FROM eventlog
INNER JOIN users ON eventlog.userID=users.userID
WHERE eventlog.logID<=10;



-- logIDが10以下のイベントログを表示
SELECT logID ,users.name
FROM eventlog
	INNER JOIN users ON users.userID = eventlog.userID
WHERE logID <= 10;


-- logIDが20番台のイベントログを表示
SELECT * FROM eventlog
WHERE logID >= 20
    AND	logID < 30;
