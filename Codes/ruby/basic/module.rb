
module TestModule

	extend self
	VAR = 2000

	def self.func
		puts "self.func()."
		@@debug = 0
	end

	func()

	def debug
		@@debug
	end

	public
	def p
		puts "Test.p()"
	end

	module Mdl
		def p
			puts "Mdl.p()"
		end
		extend self
	end

	private

	def hid
		puts "Test.hid()"
	end

	class << self
		def static
			puts "class << self"
		end
	end
end

m = TestModule
#puts m::VAR
#m::func
#m.p
#m::Mdl.p
puts m.debug
m.static
