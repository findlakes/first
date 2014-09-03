#!/usr/bin/env ruby

require File.absolute_path('./main.rb')

exps = [
# test exp n [domain]
{"id"=>1, "arg"=>"www.baidu.com"},
#{"id"=>2, "arg"=>"www.discuz.net"},
#{"id"=>3, "arg"=>"www.ytjt.com.cn"},
#{"id"=>4, "arg"=>"www.zhhsw.com"},
#{"id"=>5, "arg"=>"www.ueloo.com"},
]

exps.each do |item| 
	puts "Lanuch " + item["id"].to_s + " : " + item["arg"].to_s
	main("HOST",item["arg"])
end
