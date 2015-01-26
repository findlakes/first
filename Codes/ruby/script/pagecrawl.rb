# encoding: utf-8
require 'pp'
require 'net/http'
# Get links from a web page 

webpage = 'http://www.chinadegree.cn/'
#webpage = 'http://www.hao123.com'

begin

  uri = URI(webpage)
  res = Net::HTTP.get(uri) #puts res
  items = res.scan(/<a.*?href=['"]?(.*?)['" ].*?<\/a>/)
  #puts items.class
  #pp items
  items.each do |item|
    puts item if !item[0].start_with?('#','javascript:')
    puts "==============================" 
  end

rescue
  puts "Request failed. #{$!}"
end
