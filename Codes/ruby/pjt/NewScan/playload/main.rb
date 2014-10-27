#!/usr/bin/env ruby

require "./playload.rb"

#Test exp url
discuz_url = "http://www.zhhsw.com/"
thinkphp_url = "http://www.easy-aa.com/"
dede_url = "http://www.ueloo.com/"

Playload.run(thinkphp_url, debug=true)

Playload.each() do |issue| 
	puts "Issue detail: " + issue.to_s if issue.is_found
end
