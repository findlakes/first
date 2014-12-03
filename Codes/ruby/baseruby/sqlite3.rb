#!/usr/bin/env ruby
require "sqlite3"

create_str = '''
CREATE TABLE articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  domain varchar(255),
  status int
); '''
# status 0=>origin status 1=>working status 2=>complete status
p create_str

# Open a database
db = SQLite3::Database.new "test.db"

# Create a table
rows = db.execute create_str 

idata = [{"domain"=>"baidu.com", "status"=>0}, {"domain"=>"sina.com", "status"=>0}]

idata.each do |item|
  db.execute "insert into articles (domain,status) values ( '#{item["domain"]}', '#{item["status"]}' )"
end

# Find a few rows
db.execute( "select * from articles" ) do |row|
  p row
end
