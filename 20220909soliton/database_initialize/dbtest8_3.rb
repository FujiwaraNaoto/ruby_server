#データベースの初期化の処理
#　実際のtwitter APIに関する内容は載せていません.
#
require 'sqlite3'
require 'twitter'
require 'pp'
require "digest"

sha256=Digest::SHA256.new

# Webアプリ name passwordに関するテーブル

db = SQLite3::Database.new('userdata.db')

sql=<<-SQL
    create table if not exists usertable (
    id integer primary key autoincrement,
    name text,
    password text
  );
SQL

# usersテーブルを作成する
db.execute(sql)

# テーブルにレコードを書き込む
user1 = "admin"
password1 = "password"
#password1=sha256.digest(password1)
password1=Digest::SHA256.hexdigest("password")
#p password1
#=begin
user2="userA"
password2="AAA"
password2=sha256.hexdigest(password2)

user3="Yamada"
password3="yamada"
password3=sha256.hexdigest(password3)
#=end
db.execute("insert into usertable (name,password) values ('#{user1}','#{password1}');")
db.execute("insert into usertable (name,password) values ('#{user2}','#{password2}');")
db.execute("insert into usertable (name,password) values ('#{user3}','#{password3}');")



# selectでデータを出力する
db.execute('select * from usertable') do |row|
  p row
end

tmp = db.execute('select * from usertable')

print("tmp=",tmp)

print("tmp[0]=",tmp[0])
print("tmp[1]=",tmp[1])
print("tmp[0][0]=",tmp[1][0])

db.close


# Twitterアカウントに関数するDB

db2 = SQLite3::Database.new('userdata.db')

sql=<<-SQL
    create table if not exists apitable(
    account_id integer primary key autoincrement,
    id integer,
    account_name text,
    api_key text,
    api_secret text,
    token text,
    token_secret text
  );
SQL

db2.execute(sql)

id = 1
account_name="@id=1"
api_key="1111111111111111111111"
api_secret="2222222222222222222222"
access_token="3333333333333333333333333333333"
access_token_secret="44444444444444444444444444444"

db2.execute("insert into apitable (id,account_name,api_key,api_secret,token,token_secret) values ('#{id}','#{account_name}','#{api_key}','#{api_secret}','#{access_token}','#{access_token_secret}');")

id = 1
account_name="@id=1-1"
api_key="11111111111111111111112"
api_secret="22222222222222222222223"
access_token="333333333333333344444443333"
access_token_secret="444444444554444444444444"
db2.execute("insert into apitable (id,account_name,api_key,api_secret,token,token_secret) values ('#{id}','#{account_name}','#{api_key}','#{api_secret}','#{access_token}','#{access_token_secret}');")



id = 2
account_name="@id=2-2"
api_key="AAAAAAbbbbbbbbbbb"
api_secret="BBBBBvvvvvvvvv"
access_token="CCCdddddd"
access_token_secret="gggDDDDDDDDDD"

db2.execute("insert into apitable (id,account_name,api_key,api_secret,token,token_secret) values ('#{id}','#{account_name}','#{api_key}','#{api_secret}','#{access_token}','#{access_token_secret}');")


id = 2
account_name="@id=2"
api_key="AAAAAAAAAA"
api_secret="BBBBBBBBBBBBBB"
access_token="CCCCCCCCCCC"
access_token_secret="DDDDDDDDDDDD"

db2.execute("insert into apitable (id,account_name,api_key,api_secret,token,token_secret) values ('#{id}','#{account_name}','#{api_key}','#{api_secret}','#{access_token}','#{access_token_secret}');")

id = 3
account_name="@yamada70020066"
api_key="examlple"
api_secret="examlple"
access_token="107examlple"
access_token_secret="examlple"

db2.execute("insert into apitable (id,account_name,api_key,api_secret,token,token_secret) values ('#{id}','#{account_name}','#{api_key}','#{api_secret}','#{access_token}','#{access_token_secret}');")


id = 3
account_name="@yamada2"
api_key="yamada2"
api_secret="yamada2"
access_token="yamada2"
access_token_secret="yamada2"


db2.execute("insert into apitable (id,account_name,api_key,api_secret,token,token_secret) values ('#{id}','#{account_name}','#{api_key}','#{api_secret}','#{access_token}','#{access_token_secret}');")
db2.close


# Twitter いいね　に関するDB

db3 = SQLite3::Database.new('userdata.db')

sql=<<-SQL
    create table if not exists liketable(
    id integer primary key autoincrement,
    account_id integer,
    account_name text,
    tweet_url url,
    full_text text,
    tweet_time time,
    when_search time
  );
SQL



db3.execute(sql)

account_id=1 #apitableのaccount_tableに対応
account_name="@id=1" #@...で始まるほうのアカウント
tweet_url="http://www.example.com"
full_text="aaaaaaaaaaaaaaaaaa"
tweet_time=Time.now()
when_search=Time.now()



db3.execute("insert into liketable 
(account_id,account_name,tweet_url,full_text,tweet_time,when_search) 
values 
('#{account_id}','#{account_name}','#{tweet_url}','#{full_text}','#{tweet_time}','#{when_search}');")



# アクセストークンなどを設定
client = Twitter::REST::Client.new do |config| 
  config.consumer_key        = "example"
  config.consumer_secret     = "example"
  config.access_token        = "example"
  config.access_token_secret = "example"
end

favs = client.favorites


favs.each do |fav|


    p "=====================TWItter========================="

    print("account_name=")#投稿主のアカウント
    account_name="@"+fav.user.screen_name
    print(account_name,"\n")
    print("account_name.class=")
    print(account_name.class,"\n") #String class


    #投稿のURL
    tweet_url=fav.url.origin+"/"+fav.user.screen_name+"/"+"status"+"/"+fav.id.to_s
    print("tweet_url.class=",tweet_url.class)
    print("\n")
    print("tweet_url=",tweet_url)
    print("\n")

    #内容
    contents=fav.full_text
    print("contents.class=")#=String
    print(contents.class)
    print("\n")
    print("contents=",contents,"\n")

    #その投稿があった時間
    time=fav.created_at
    print("time=",time,"\n")

    print("time.class=",time.class,"\n")
    
    account_id=5
    db3.execute("insert into liketable 
    (account_id,account_name,tweet_url,full_text,tweet_time,when_search) 
    values 
    ('#{account_id}','#{account_name}','#{tweet_url}','#{contents}','#{time}','#{Time.now()}');")

end








db3.execute("select * from liketable") do |row|
    p row
end  

db3.close


db3.close

db4 = SQLite3::Database.new('userdata.db')

#掲示板に関するDB
#ユーザid 
# いつ投稿されたか
#content varchar(100)
sql4=<<-SQL
    create table if not exists bulletin_table(
    post_id integer primary key autoincrement,
    id integer,
    user text,
    when_post time,
    content text
  );
SQL

db4.execute(sql4)

id=1
user="admin"
#content="who am I?-I'm admin"#空白を含む文字のときに困るな...
content="dddddd"


db4.execute("INSERT INTO bulletin_table(id,user,when_post,content)
VALUES('#{id}','#{user}','#{Time.now()}','#{content}');")

content="これは不適切な発言です"
db4.execute("INSERT INTO bulletin_table(id,user,when_post,content)
VALUES('#{id}','#{user}','#{Time.now()}','#{content}');")



id=2
user="userA"
content="Hello"

db4.execute("insert into bulletin_table 
(id,user,when_post,content) 
values 
('#{id}','#{user}','#{Time.local(2017, 6, 1, 9, 33, 45, 0)}','#{content}');")


id=3
user="Yamada"
content="KittyOnYourLap"

db4.execute("insert into bulletin_table 
(id,user,when_post,content) 
values 
('#{id}','#{user}','#{Time.now()}','#{content}');")


content="example"
db4.execute("insert into bulletin_table 
(id,user,when_post,content) 
values 
('#{id}','#{user}','#{Time.now()}','#{content}');")


content="<script>alert(\"Hello\")</script>" #javascript
db4.execute("insert into bulletin_table 
(id,user,when_post,content) 
values 
('#{id}','#{user}','#{Time.now()}','#{content}');")




db4.execute("select * from bulletin_table") do |row|
    p row
end  


db4.close


