#
# Module:
# Fingerprint Identification
#

module Identification

	MODULE_NAME = "Fingerprint Identification"

	TUPLES = 
	[
		{"finger"=>"Discuz","desc"=>""},
		{"finger"=>"Dedecms","desc"=>""},
		{"finger"=>"WordPress","desc"=>""},
	]

	def self.run(global)
		global.debug("START #{MODULE_NAME}...")
		#global.debug("#{TUPLES}...")
		global.debug("#{global.to_s}...")
	end

end
