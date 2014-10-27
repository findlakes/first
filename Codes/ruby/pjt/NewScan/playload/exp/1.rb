# encoding: utf-8

class Exploit_1 < Playload::Issue

    def initialize
        @name			= "Base Name"
        @type			= "Base Type"
        @tags 			= "Test tags"
        @description	= "Base Desc"
        @references		= {}
        @severity 		= :high
        @remedy_guidance = "Test Guide"
        @is_found 		= false
        @is_error 		= false
    end

    def exp(url)
        @is_found = true
    end

end

Playload::Queue.add Exploit_1.new
