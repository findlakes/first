#!/usr/bin/env ruby
require "sqlite3"

class Mytask
  def initialize(dbname = "task.db", tbname = "tasks")
    @dbname = dbname
    @tbname = tbname
    @db = SQLite3::Database.new(dbname)
  end

  def create
    # status 0=>origin status 1=>working status 2=>complete status
    @db.execute "CREATE TABLE #{@tbname} (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, domain varchar(255), status int);"
  end
  def insert(domain,status)
    @db.execute "insert into #{@tbname} (domain,status) values ('#{domain}', '#{status}')"
  end
  def delete(id)
    @db.execute "delete from #{@tbname} where id = #{id}"
  end
  def get_origin
    @db.execute( "select * from #{@tbname} where status = 0")
  end
  def get_work
    @db.execute( "select * from #{@tbname} where status = 1")
  end
  def get_complete
    @db.execute( "select * from #{@tbname} where status = 2")
  end
  def set_origin(id)
    @db.execute( "update from #{@tbname} set status = 0 where id = #{id}")
  end
  def set_work(id)
    @db.execute( "update from #{@tbname} set status = 1 where id = #{id}")
  end
  def set_complete(id)
    @db.execute( "update from #{@tbname} set status = 2 where id = #{id}")
  end
end

#my = Mytask.new "test.db"
#my.insert("a.com",1)
#my.insert("b.com",2)
#p my.get_origin
#p my.get_work
#p my.get_complete
