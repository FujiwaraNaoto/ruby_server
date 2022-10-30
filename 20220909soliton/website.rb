require 'sinatra'
require 'sinatra/reloader'
require 'erb'
require 'sqlite3'

require 'twitter' #for twitter
require 'pp'
#require 'unix-crypt' #暗号化に使うライブラリ
require 'digest'

require "erb"
include ERB::Util #サニタイジングに必要


=begin
https://qiita.com/shiopon01/items/4490ecc1deaef72823dd
ビューのフォルダの分け方
get '/hoge' do
  erb 'hoge/index'.to_sym
  erb :'hoge/index' #値はシンボルで渡す必要がある
end
=end

database_name="userdata.db"#データベースに関係するもの
database_table_name="usertable"

#cookieに必要
set :sessions,
    expire_after: 60*60,#60*60 seconds
    secret: 'key'

set :environment, :production

sha256=Digest::SHA256.new


get '/' do
    erb :login
end

#新しいuserの登録 
get '/registration' do
   
    @new_user_message=""
    erb :new_user
end

#新しいuserの登録
post '/sign_up' do
    new_name = params[:new_name]
    new_passwd = sha256.hexdigest(params[:new_passwd]) #ハッシュ化した値を入れるとする
    print("new_name=")
    puts new_name
    print("new_passwd=")
    puts new_passwd

    print("new_name.clas=")
    puts new_name.class
    print("new_passwd.class=")
    puts new_passwd.class


    if(new_name.empty? || new_passwd.empty?)then
   
        print("empty\n")
        @new_user_message="Either Password or Username is empty"
        erb :new_user

    else 
        db = SQLite3::Database.new(database_name)
        sql= "SELECT COUNT(*) FROM usertable WHERE name=? AND password=?"
        ans=db.execute(sql,new_name,new_passwd)
        #二次元配列で返却
        if(ans[0][0]>0) then
            #すでに登録済みのパスワードがある場合.
            
            db.close
            @new_user_message = "Enter different name and password."
            erb :new_user
        else
            sql="INSERT INTO usertable (name,password) VALUES (?,?)"
            db.execute(sql,new_name,new_passwd)
            db.close
            @new_user_name=new_name
            erb :registration
        end
    end
end

# webisteへのログイン
post '/login' do
    user = params[:user]
    passwd = sha256.hexdigest(params[:passwd]) #ハッシュ化

    if(user=="a" && passwd==sha256.hexdigest("a")) then
        redirect '/admin_page'
    else

    
        db = SQLite3::Database.new(database_name)
        
        
        sql="SELECT COUNT(*) FROM usertable WHERE name=? AND password=?;"
        ans=db.execute(sql,user,passwd)

        if(ans[0][0]>0) then
            
            sql="SELECT * FROM usertable WHERE name=? AND password=?;"
            user_information=db.execute(sql,user,passwd)
           
            db.close
            puts "login success"
            session[:user_login_name]=user_information[0][1] 
            session[:user_login_id]=user_information[0][0] 
            
            session[:message]=user+passwd
            session[:login_flag]=true
            
            redirect '/is_content_show'
        else
            db.close
            puts "login fail"
          
            session[:login_flag]=false
            redirect '/is_content_show'
            
        end
        
        #db.close

    end
end

# 本当にログインできるか,セッションで判断
get '/is_content_show' do
    if(session[:login_flag]) then
        #@user_login_name = session[:user_login_name]
        #@user_login_id= session[:user_login_id]

        redirect '/login_success'
      
    else
        redirect '/login_failure'
    end

end

#ログインに成功. メニュー画面の表示
get '/login_success' do
    if session[:login_flag].nil? then
        redirect '/'
    else
       
        @user_login_name = session[:user_login_name]
        @user_login_id= session[:user_login_id]
        erb :login_success
    end
end

# twitter
#
get '/register_twitter_account' do
    if session[:login_flag].nil? then
        redirect '/logout'
    end

    @user_login_id= session[:user_login_id]
    erb 'twitter/register_twitter_account'.to_sym
    erb :'twitter/register_twitter_account'
end

# 仮登録のtwitter APIが本当に正しいかどうかを尋ねる
#
#
post '/twitter_account_confirmation' do
    if session[:login_flag].nil? then
        redirect '/logout'
    end

    @account_name = params[:account_name]
    @api_key=params[:api_key]
    @api_secret = params[:api_secret]
    @token = params[:token]
    @token_secret = params[:token_secret]
    print("account_name=",@account_name,"\n")
    print("api_key=",@api_key,"\n")
    print("api_secret=",@api_secret,"\n")
    print("token=",@token,"\n")
    print("token_secret=",@token_secret,"\n")
   
    

    if(@account_name.empty? || @api_key.empty? || @api_secret.empty? || @token.empty? || @token_secret.empty? || @account_name.slice(0)!="@") then
        redirect '/register_twitter_account'
    else 

    erb 'twitter/twitter_account_confirmation'.to_sym
    erb :'twitter/twitter_account_confirmation'
   
    end
end


# 一人の人間が複数のアカウントを持つ可能性があるので
#アカウントの新規登録
post "/twitter_registration_completed" do
    if session[:login_flag].nil? then
        redirect '/logout'
    end


    print("params[:twitter_account_name]=")
    p params[:twitter_account_name]
    print("params[:twitter_api_key]=")
    p params[:twitter_api_key]
    print("params[:twitter_api_secret]=")
    p params[:twitter_api_secret]
    print("params[:twitter_token]=")
    p params[:twitter_token]
    print("params[:twitter_token_secret]=")
    p params[:twitter_token_secret]

    user_login_id= session[:user_login_id]
    print("user_login_id=")
    p user_login_id
    db = SQLite3::Database.new(database_name)
        
    sql="SELECT COUNT(*) FROM apitable 
    WHERE id=? 
    AND account_name=? 
    AND api_key=?
    AND api_secret=?
    AND token=?
    AND token_secret=?;"

    does_exist=db.execute(sql,
    user_login_id,
    params[:twitter_account_name],
    params[:twitter_api_key],
    params[:twitter_api_secret],
    params[:twitter_token],
    params[:twitter_token_secret]
    )
    p does_exist
    p does_exist[0]
    print("does_exist[0][0]=",does_exist[0][0],"\n")
    #もしくはセッションが切れていた場合

    @twitter_account_register_result
    if(does_exist[0][0]>0) then
        #すでにデータベースにあった場合は何もしない.
        @twitter_account_register_result="You've already registered this account :"+params[:twitter_account_name]
        db.close
        erb 'twitter/register_twitter_account_confirmation'.to_sym
        erb :'twitter/register_twitter_account_confirmation'
    else
       
        sql="INSERT INTO apitable 
            (id,account_name,api_key,api_secret,token,token_secret) VALUES
            (?,?,?,?,?,?);"

        db.execute(sql,
        user_login_id,
        params[:twitter_account_name],
        params[:twitter_api_key],
        params[:twitter_api_secret],
        params[:twitter_token],
        params[:twitter_token_secret])
        
        db.close
        
        @twitter_account_register_result="Account :"+params[:twitter_account_name]+" Registration completed"
        erb 'twitter/register_twitter_account_confirmation'.to_sym
        erb :'twitter/register_twitter_account_confirmation'
    end
    

end



# website　id　から　紐づいているtwitterのアカウントを取り出す
#
get '/twitter_search' do
    if session[:login_flag].nil? then
        redirect '/logout'
    end

    @user_login_name_twitter = session[:user_login_name]
    @user_login_id_twitter= session[:user_login_id]

    #@user_twitter_like=""
    #@user.languages=[]

    db = SQLite3::Database.new(database_name) 
    sql = "select * from apitable where id=?;" 
    @twitter_api_list=db.execute(sql,@user_login_id_twitter)

    erb 'twitter/twitter_search2'.to_sym
    erb :'twitter/twitter_search2'
end


get '/twitter_like_list' do
    if session[:login_flag].nil? then
        redirect '/'
    end
    erb 'twitter/twitter_like_list2'.to_sym
    erb :'twitter/twitter_like_list2'

end

# ボタン操作での分岐
#タイムライン
get '/twitter_time_line' do
    if session[:login_flag].nil? then
        redirect '/logout'
    end

    @user_twitter_time_line=[]
    erb 'twitter/twitter_time_line'.to_sym
    erb :'twitter/twitter_time_line'
end

# like, all like, timeline に行く機能
# それぞれの場合分け
post '/twitter_operate' do
    print("params[:id]=",params[:id],"\n")
    print("params[:button]=",params[:button],"\n")
    print("params[\"button\"]=",params["button"],"\n")
    which_button=params["button"]
    print("which_button=",which_button)
    case which_button
    when "like_button"
        session[:twitter_account_id]=params[:id].to_i;
        redirect '/twitter_like'

    when "all_like_button"
        session[:twitter_account_id]=params[:id].to_i
        redirect '/twitter_all_like'

    when "Time_line_button"
        session[:twitter_account_id]=params[:id].to_i;
        redirect '/try_twitter_time_line'
    else 
        redirect '/twitter_search'
    end
end


# アクセストークンなどを設定
#一人がたくさんのアカウントを持っている可能性があるので
# いいね　を取得
get "/twitter_like" do
    if session[:login_flag].nil? then
        redirect '/logout'
    end


    id=session[:twitter_account_id]
    print("id=",id,"\n")
    
    if(id==0) then
        redirect '/twitter_search'
    end

 
    db = SQLite3::Database.new(database_name) 
    sql = "select * from apitable where account_id=?;"
    twitter_account_information = db.execute(sql,id)
    db.close
    print("twitter_account_information =")
    print(twitter_account_information)
    print("\n")


    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = twitter_account_information[0][3]
        config.consumer_secret     = twitter_account_information[0][4]
        config.access_token        = twitter_account_information[0][5]
        config.access_token_secret = twitter_account_information[0][6]
    end
   

    @user_id = twitter_account_information[0][0]

    #これはうまく動く
    #@user_twitter_like_list=client.favorites
    # https://qiita.com/ts-3156/items/f35f6f333918f3ffa286
    # https://github.com/sferik/twitter
    

    
    begin
        @user_twitter_like_list=client.favorites

        db = SQLite3::Database.new(database_name)  
        sql_insert = "INSERT INTO liketable (account_id,account_name,tweet_url,full_text,tweet_time,when_search) values (?,?,?,?,?,?);"
        sql_search = "SELECT COUNT(*) FROM liketable where tweet_url=?"
        @user_twitter_like_list.each do |fav|
            
            tweet_url =fav.url.origin+"/"+fav.user.screen_name+"/"+"status"+"/"+fav.id.to_s 
            is_contained_tweet =  db.execute(sql_search,tweet_url)
            if(is_contained_tweet[0][0]>0) then
                #pass
                print("is_contained_tweet[0][0]=")
                p is_contained_tweet[0][0]

            else
                account_name = "@"+fav.user.screen_name
                #tweet_url =fav.url.origin+"/"+fav.user.screen_name+"/"+"status"+"/"+fav.id.to_s 
                content = fav.full_text 
                tweet_time = fav.created_at
                account_id = @user_id
                db.execute(sql_insert,account_id,account_name,tweet_url,content,tweet_time.to_s,Time.now().to_s)
            end
        end

        db.close 


        erb 'twitter/twitter_like_list2'.to_sym
        erb :'twitter/twitter_like_list2'
        #api_client.request_something
    rescue Twitter::Error::Unauthorized => e
        
        puts "error message=##{e.class}, #{e.message}"
        @twitter_api_error_message = "#{e.class}, #{e.message}"
        @twitter_account_name = twitter_account_information[0][2]
        #erb :twitter_api_error

        erb 'twitter/twitter_api_doesnt_work.to_sym'
        erb :'twitter/twitter_api_doesnt_work'
    
    end

end

#過去の「いいね」内容をすべて表示させる
get "/twitter_all_like" do
    if session[:login_flag].nil? then
        redirect '/logout'
    end

    id = session[:twitter_account_id];
    if(id==0) then
        redirect '/twitter_search'
    end

    print("twitter_all_like id=",id,"\n")
    db = SQLite3::Database.new(database_name) 
    sql = "select * from liketable WHERE account_id=? ORDER BY id DESC;"
   
    @all_like=db.execute(sql,id) #account_idがすべておなじもの
    db.close

    erb 'twitter/twitter_all_like'.to_sym
    erb :'twitter/twitter_all_like'

    
end


# twitter time lineを試みる場合
get '/try_twitter_time_line' do
        if session[:login_flag].nil? then
            redirect '/logout'
        end
    
      
        if(session[:twitter_account_id]==0) then #何も選ばない場合
            redirect '/twitter_search'
        else
            redirect '/twitter_time_line'
          
        end
end
    

#twitterの検索キーワードと何個の記事を表示するか?　を出力
post '/twitter_time_line' do
    if session[:login_flag].nil? then
        redirect '/logout'
    end


    cnt=params[:cnt].to_i
    keyword=h(params[:keyword])#サニタイジング処理

    print("cnt=",cnt)
    print("keyword=",keyword)

    if(cnt==0 || keyword=="") then
        puts "red"
        redirect '/twitter_time_line'
    end
    
    twitter_account_id = session[:twitter_account_id];
    
    db = SQLite3::Database.new(database_name) 
    sql = "select * from apitable where account_id=?;"
    twitter_account_information = db.execute(sql,twitter_account_id)
    print("twitter_account_information =")
    print(twitter_account_information)
    print("\n")

    
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = twitter_account_information[0][3]
        config.consumer_secret     = twitter_account_information[0][4]
        config.access_token        = twitter_account_information[0][5]
        config.access_token_secret = twitter_account_information[0][6]
    end
    
    #遭遇したエラー内容
    #Twitter::Error::NotFound, Sorry, that page does not exist.
    #Error message is Twitter::Error::Unauthorized, Not authorized.

    begin
        @user_twitter_time_line=client.user_timeline(keyword, count: cnt)
        print(" @user_twitter_time_line=",@user_twitter_time_line)        
            
        erb 'twitter/twitter_time_line'.to_sym
        erb :'twitter/twitter_time_line'

    rescue Twitter::Error => e

        puts "error message=##{e.class}, #{e.message}"
        @twitter_api_error_message = "#{e.class}, #{e.message}"
       
        erb 'twitter/twitter_api_doesnt_work.to_sym'
        erb :'twitter/twitter_api_doesnt_work'
    end
    
end


#データベースの内容を消す場合
get '/admin_page' do
    db = SQLite3::Database.new(database_name)
    #sql="SELECT * FROM bulletin_table"
    sql_bulletin="SELECT * FROM bulletin_table ORDER BY post_id DESC"
    @bulletin_board_content = db.execute(sql_bulletin)

    sql_users_list="select * from usertable;"

    @all_user_list=db.execute(sql_users_list)
    
    db.close
   
    erb :admin_page2

end

get '/logout' do
    session.clear
    erb :logout
end

get '/login_failure' do
    erb :login_failure
end

#データベースからアカウント(loginに必要な機能)の削除を行う
post '/delete_db' do
    p params[:id] # => ["1","3"]

    if(params[:id].nil?) then
        redirect '/admin_page'
    else
        p "***who**********"
        db = SQLite3::Database.new(database_name)

        params[:id].each do |i|
            #p i # => "1" or "3"
            print("i=")
            p i.to_i
            sql="DELETE FROM usertable WHERE id=?"
            db.execute(sql,i.to_i)
         
        end

        db.close
        #消去したあとでlogin pageへ戻る.
        redirect '/admin_page'

    end

end


#fileアップロード機能
get '/file_upload' do
    image_name=Dir.glob("public/files/*")
    @files_path=[]
    image_name.each do |a|
        @files_path << a.gsub("public/files/","")
    end
    erb 'file_uploader/up_loader'.to_sym
    erb :'file_uploader/up_loader'
    
end

post '/upload_the_file' do
    s=params[:file]

    if(s.nil?) then
        redirect '/file_upload'
    else

        file_save_path="./public/files/#{params[:file][:filename]}"
        puts "file_save_path"
        puts file_save_path
        File.open(file_save_path,'wb') do |f|
            g=params[:file][:tempfile]
            f.write g.read
        end
       
        redirect '/file_upload'

    end
end


#掲示板に関するもの
get '/bulletin_board' do
    @user_login_id= session[:user_login_id]
    db = SQLite3::Database.new(database_name)
    sql="SELECT name FROM usertable where id=?"
    @user_name=db.execute(sql,@user_login_id)[0][0]

    sql="SELECT * FROM bulletin_table ORDER BY post_id DESC"
    @bulletin_board_content = db.execute(sql)

    db.close
    erb 'bulletin_board/bulletin'.to_sym
    erb :'bulletin_board/bulletin'
end

post '/bulletin_submit' do
    params[:user_name]
    params[:user_id]

    db = SQLite3::Database.new(database_name)
    #いつ投稿はサーバ側の時間かどうか
    sql="INSERT INTO bulletin_table (id,user,when_post,content) VALUES (?,?,?,?)"
    db.execute(sql,params[:user_id].to_i,params[:user_name],Time.now().to_s,params[:comment])
    db.close

    redirect '/bulletin_board'

end


#掲示板を更新　不適切なコメントを消去
post "/delete_bulletin_board" do
    p params[:delete_comment]
    if(params[:delete_comment].nil?) then
        redirect  '/admin_page'
    end
   
    p "************" 
    print("params[:delete_comment]=",params[:delete_comment])
        db = SQLite3::Database.new(database_name)

        admin_id=1
        admin_user="admin"
        delete_content="Deleted due to unsuitable comments..."#"不適切な発言で削除されました"


        params[:delete_comment].each do |i|
            #p i # => "1" or "3" for debugging
            #p i.to_i
            
            sql="UPDATE bulletin_table SET id=?, user=?,when_post=?,content=? WHERE post_id=?"
            db.execute(sql,
            admin_id,
            admin_user,
            Time.now().to_s,
            delete_content,
            i.to_i)
            
        end

        db.close
        #消去したあとでlogin pageへ戻る.
        redirect '/admin_page'


end

get '/calender' do
    today=Time.now
    year = today.year
    month = today.month
    #redirect "http://192.168.80.131:4567/#{today.year}/#{today.month}"
    redirect "/#{today.year}/#{today.month}"
end

#カレンダー機能　month_calenderに渡す
#仕様しなかった
# @tにhtmlの構文を書いてしまう(ふつうはこのような書き方を行わない.とのこと)
get '/:year/:month' do
       
    @year = params[:year].to_i #整数型に変換
    @month = params[:month].to_i #日に変換
    
    if(@month>=13) then
        @year=@year+1
        @month=1
    elsif(@month<=0) then
        @year = max(@year,1)
        @month=12
    end

    
    if(@year<=0 || @month<=0 || 12<@month ) then #ここでバグる
        redirect "/calender"
    end

    @t="<table border><tr><th><font color=\"red\">Sun</font></th>"
    @t=@t+"<th><font color=\"white\">Mon</font></th>"
    @t=@t+"<th><font color=\"white\">Tue</font></th>"
    @t=@t+"<th><font color=\"white\">Wed</font></th>"
    @t=@t+"<th><font color=\"white\">Thu</font></th>"
    @t=@t+"<th><font color=\"white\">Fri</font></th>"
    @t=@t+"<th><font color=\"blue\">Sat</font></th></tr>"
    
    day_limit = get_Last_Day(@year,@month)#lまで
    start = zeller(@year,@month,1)#ツェラーの公式を利用 year年 month月 1日
    print("day_limit=",day_limit)
    day=1
    6.times do |p| # maxでもq=6 p~0,1,2,3,4,5
    #for p in 0..5 do
        @t=@t+"<tr>"
        7.times do |q|
        #for p in 0..6 do #一週間
            if (p==0 && q<start) then
                @t=@t+"<td></td>"
            else
                if (day<=day_limit) then
                    

                    if(q==0) then #日曜日の場合
                        
                        tmpday="<font color=\"red\">#{day}</font>"
                      
                    elsif(q==6) then
                       
                        tmpday="<font color=\"blue\">#{day}</font>"
                    else
                        tmpday="<font color=\"white\">#{day}</font>"
                    end

                    @t=@t+"<td align=\"right\">#{tmpday}</td>"

                    day+=1
                else
                    @t=@t+"<td></td>"
                end
            end
        end
    
        @t=@t+"</tr>"
        if(day>day_limit) then
            break
        end
    end

    @t=@t+"</table>"

    erb :month_calender
end#get の終わり   
    
    
#西暦year年　month日が何日まであるか
def get_Last_Day(year,month)
    # 1=31,2=28,3=31,4=30,5=31,6=30,7=31,8=31,9=30,10=31,11=30,12=31
    month_array=[nil,31,28,31,30,31,30,31,31,30,31,30,31]
    
    if(is_Leap_Year(year) && month==2) then
        return month_array[2]+1
        #month_array[2]=month_array[2]+1 #2月が29日
    end
    
    return month_array[month]
end

#ツェラーの公式を利用 year年 month月 1日
def zeller(year, month, d)
    # 1月, 2月は前年の13月, 14月として計算 
    if month == 1 || month == 2
      month += 12
      year  -= 1
    end
  
    # ツェラーの公式用の数を求める
    h = year / 100
    y = year % 100
    m = month
  
    # 曜日計算
    return (y + (y / 4) + (h / 4) - (2 * h) + ((13 * (m + 1)) / 5) + d-1+7) % 7
  
    end




#うるう年判定
#西暦が4で割り切れない
# 西暦が100で割り切れるけど400で割り切れない
def is_Leap_Year(year)
    
    if(year%4!=0) then
        return false
    elsif(year%100==0 && year%400!=0) then
        return false
    else
        return true
    
    end
end