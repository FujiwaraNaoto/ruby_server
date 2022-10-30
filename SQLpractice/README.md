
See paiza 
https://paiza.jp/works/sql/primer/beginner-sql2
for more detail.
<style>
.line1 { text-decoration: underline solid black }
.line2 { text-decoration: underline double black }

</style>

Table structure
<div>
<u>primary key</u>
 <p style="text-decoration:underline; text-decoration-color:#FF0000;">foreign key</p>
**はforeign key
イベントアクセス記録

eventlog テーブル
- <u>logID</u>
- <p style="text-decoration:underline; text-decoration-color:#FF0000;">userID</p>
- <p style="text-decoration:underline; text-decoration-color:#FF0000;">eventID</p>
- startTime
- endTime


ユーザ一覧
usersテーブル
- <u>userID</u>
- name 
- <p style="text-decoration:underline; text-decoration-color:#FF0000;">jobID</p>
- level
- exp
- gold
- deleted_at
- birth
- <p style="text-decoration:underline; text-decoration-color:#FF0000;">areaID</p>


職業一覧
jobs
- <u>jobID</u>
- job_name

都道府県一覧
area
- <u>areaID</u>
- area_name

イベント一覧
events
- <u>eventID</u>
- event_title
- event_state
- event_summary
- event_url
- increase_exp
- increase_gold

</div>