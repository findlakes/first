#
# Module:
# Information Collection.
#
module Collection

	MODULE_NAME = "Information Collection"

	TUPLES = 
	[
		{"page"=>"index.html","desc"=>""},
		{"page"=>"http://www.baidu.com/","desc"=>""},
	]
                    
	def self.run(global)
		global.debug("START #{MODULE_NAME}...")
		#global.debug("#{TUPLES}...")
		global.debug("#{global}...")
	end

end

