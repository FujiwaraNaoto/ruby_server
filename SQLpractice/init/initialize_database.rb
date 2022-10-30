#users tableに関してはクリア
require "sqlite3"

db_file_name="database_list.db"


#################################################
# users
####################################################

begin
    db=SQLite3::Database.new(db_file_name)

rescue SQLite3::SQLException
    p "db error"

end


sql_users=<<-SQL
create table if not exists users(
    userID integer primary key,
    name varchar(10),
    jobID integer,
    level integer,
    exp integer,
    gold integer,
    deleted_at Time,
    birth Time,
    areaID integer
);
SQL


 



begin
    db.execute(sql_users)
rescue SQLite3::SQLException
    p "db error"    

end



#usersテーブルの代入
#=begin
File.open("users.txt", mode = "rt"){|f|
    f.each_line{|line|
    
    line=line.chomp
    s=line.split("\t")
    #p s
    if(s[6]=="NULL") then 
        s[6]=nil
    else
        s[6]=Time.parse(s[6]).to_s
    end


    if(s[7]=="NULL") then 
        s[7]=nil
    else
        s[7]=Time.parse(s[7]).to_s
    end

    table=[ s[0].to_i,
            s[1],
            s[2].to_i,
            s[3].to_i,
            s[4].to_i,
            s[5].to_i,
            s[6],
            s[7],
            s[8].to_i]

    #p table
    if(table[6].nil?) then
        insert_sql_users="insert into users
        (userID, name,jobID,level,exp,gold,birth,areaID) 
        values (?,?,?,?,?,?,?,?)"

        begin
            db.execute(insert_sql_users,table[0],table[1],table[2],table[3],table[4],table[5],table[7],table[8]) 
        rescue SQLite3::SQLException
            p "db error"
        
        end
        
    else

        insert_sql_users="insert into users 
        (userID, name,jobID,level,exp,gold,deleted_at,birth,areaID) 
        values (?,?,?,?,?,?,?,?,?)"

        begin
            db.execute(insert_sql_users,table[0],table[1],table[2],table[3],table[4],table[5],table[6],table[7],table[8]) 

        rescue SQLite3::SQLException
            p "db error"    
        
        end

    end
    
  }
}


db.close


############################################################
#ここからeventlog
###########################################################

begin
    db=SQLite3::Database.new(db_file_name)

rescue SQLite3::SQLException
    p "db error in opening db table in eventlog"

end




sql_eventlog=<<-SQL
create table if not exists eventlog(
    logID integer primary key,
    userID integer,
    eventID integer,
    startTime Time,
    endTime Time
);
SQL



begin
    db.execute(sql_eventlog)
rescue SQLite3::SQLException
    p "db error in creating eventlog table"    

end


#=begin

File.open("eventlog.txt", mode = "rt"){|f|
    f.each_line{|line|

        line=line.chomp
        s=line.split("\t")
        
        
        s[3]=Time.parse(s[3]).to_s
        s[4]=Time.parse(s[4]).to_s

        #s[3]=Date.parse(s[3])
        #s[4]=Date.parse(s[4])



        logid_table=[
                s[0].to_i,
                s[1].to_i,
                s[2].to_i,
                s[3],
                s[4]
            ]

        #p logid_table

        insert_sql_eventlog="insert into eventlog 
        (logID,userID, eventID,startTime, endTime) 
        values (?,?,?,?,?)"

        begin
            db.execute(insert_sql_eventlog,logid_table[0],logid_table[1],logid_table[2],logid_table[3],logid_table[4]) 
        rescue SQLite3::SQLException
            #p "db error"    
        
        end
        }
    }

db.close


##########################################################
#ここからjobs
########################################################



begin
    db=SQLite3::Database.new(db_file_name)

rescue SQLite3::SQLException
    p "db error in opening db"

end


sql_jobs=<<-SQL
create table if not exists jobs(
    jobID integer primary key,
    job_name varchar(20)
);
SQL



begin
    db.execute(sql_jobs)
rescue SQLite3::SQLException
    p "db error in creating jobs table"    

end



File.open("jobs.txt", mode = "rt"){|f|
    f.each_line{|line|

        line=line.chomp
        s=line.split("\t")
        
        jobs_table=[
                s[0].to_i,
                s[1]
            ]

        #p jobs_table

        insert_sql_jobs="insert into jobs 
        (jobID,job_name) 
        values (?,?)"

        begin
            db.execute(insert_sql_jobs,jobs_table[0],jobs_table[1]) 
        rescue SQLite3::SQLException
            #p "db error"    
        
        end
        }
    }

db.close




##########################################################
#ここからarea
########################################################



begin
    db=SQLite3::Database.new(db_file_name)

rescue SQLite3::SQLException
    p "db error in opening db"

end


sql_area=<<-SQL
create table if not exists area(
    areaID integer primary key,
    area_name varchar(20)
);
SQL



begin
    db.execute(sql_area)
rescue SQLite3::SQLException
    p "db error in creating area table"    

end


#=begin
File.open("area.txt", mode = "rt"){|f|
    f.each_line{|line|

        line=line.chomp
        s=line.split("\t")
        
        area_table=[
                s[0].to_i,
                s[1]
            ]

        #p area_table

        insert_sql_area="insert into area 
        (areaID,area_name) 
        values (?,?)"

        begin
            db.execute(insert_sql_area,area_table[0],area_table[1]) 
        rescue SQLite3::SQLException
            p "db error"    
        
        end
        }
    }


db.close





##########################################################
#ここからevents
########################################################



begin
    db=SQLite3::Database.new(db_file_name)

rescue SQLite3::SQLException
    p "db error in opening db"

end


sql_events=<<-SQL
create table if not exists events(
    eventID integer primary key,
    event_title varchar(20),
    event_stage integer,
    event_summary varchar(20),
    event_url varchar(20),
    increase_exp integer,
    increase_gold integer
);
SQL



begin
    db.execute(sql_events)
rescue SQLite3::SQLException
    p "db error in creating events table"    

end


#usersテーブルの代入
#=begin
File.open("events.txt", mode = "rt"){|f|
    f.each_line{|line|
    
    line=line.chomp
    s=line.split("\t")
    
    events_table=[
            s[0].to_i,
            s[1],
            s[2].to_i,
            s[3],
            s[4],
            s[5].to_i,
            s[6].to_i
            ]
    
        insert_sql_events="insert into events 
        (eventID, event_title,event_stage,event_summary,event_url,increase_exp,increase_gold) 
        values (?,?,?,?,?,?,?)"

        begin
            db.execute(insert_sql_events,events_table[0],events_table[1],events_table[2],events_table[3],events_table[4],events_table[5],events_table[6]) 
        rescue SQLite3::SQLException
            p "db error"
        
        end
        #p events_table
  }
}


db.close

