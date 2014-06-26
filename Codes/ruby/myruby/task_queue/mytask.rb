#!/usr/bin/env ruby
require "sqlite3"

class Mytask
  def initialize(dbname = "task.db", tbname = "tasks")
    @dbname = dbname
    @tbname = tbname
    @db = SQLite3::Database.new(dbname)
  end

  def create
    # status means 
    # 0=>origin
    # 1-99=>work 
    # 100=>complete
    # 101 => error 1 
    @db.execute "CREATE TABLE #{@tbname} (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, domain varchar(255), status int);"
  end
  def insert(id,domain,status)
    @db.execute "insert into #{@tbname} (id,domain,status) values (#{id},'#{domain}', '#{status}')"
  end
  def delete(id)
    @db.execute "delete from #{@tbname} where id = #{id}"
  end
  def list_origin
    @db.execute( "select * from #{@tbname} where status = 0")
  end
  def list_work
    @db.execute("select * from #{@tbname} where status > 0 and status < 100")
  end
  def list_complete
    @db.execute("select * from #{@tbname} where status = 100")
  end
  def set_origin(id)
    @db.execute( "update #{@tbname} set status = 0 where id = #{id}")
  end
  def set_work(id)
    @db.execute( "update #{@tbname} set status = 1 where id = #{id}")
  end
  def set_complete(id)
    @db.execute( "update #{@tbname} set status = 100 where id = #{id}")
  end
  def get_task(id)
    @db.execute( "select * from #{@tbname} where id = #{id}")
  end
end

if __FILE__ == $0
my = Mytask.new "a.db"
#my.insert("baidu.com",0)
my.insert("sohu.com",0)
#my.insert("www.hao123.com",0)
#my.set_complete(1)
#p my.list_origin
end
