#!/usr/bin/env ruby

require "sqlite3"

class Task

  def initialize(dbname='task.db', tbname='task')
    @dbname = dbname
    @dbname = tbname
    @db     = SQLite3::Database.new(dbname)
	@db.create
  end

  def create
    @db.execute ''' 
      CREATE TABLE IF NOT EXISTS task (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        status int,
        target text,
        policy text,
        result text,
        start  TimeStamp, 
        stop   TimeStamp
      ); 
    '''
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
my = Mytask.new
my.create
end

