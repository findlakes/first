require 'net/http'
require "digest/md5"

uri = URI('http://www.lol.com/')
body = Net::HTTP.get(uri)

md5 = Digest::MD5.hexdigest(body)

puts md5
