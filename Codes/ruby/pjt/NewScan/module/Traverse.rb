#
# Module:
# Element Traverse.
#
module Traverse

	MODULE_NAME = "Element Traverse"

	TUPLES = 
	[
		{"page"=>"index.html","desc"=>""},
		{"page"=>"http://www.baidu.com/","desc"=>""},
	]
                    
	def self.run(global)
		global.debug("START #{MODULE_NAME}...")
		#global.debug("#{TUPLES}...")
		global.debug("#{global.to_s}...")
	end

end

