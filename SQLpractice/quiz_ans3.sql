
-- userIDが50番以降のアクティブユーザーを表示する
SELECT *
FROM
	users
WHERE
	users.userID >= 50 AND deleted_at IS NULL;



-- 東京都のアクティブユーザーを表示する
SELECT *
FROM
	users
	INNER JOIN area ON area.areaID = users.areaID
WHERE
	deleted_at IS NULL AND area_name='東京都';


