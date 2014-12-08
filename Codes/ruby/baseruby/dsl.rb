class Find

	@@ary = []

	def self.do(&block)
		if block_given?
			@@ary << self.new(&block)
		else
			@@ary.each do |a| a.eval end
		end
	end

	def initialize(&block)
		@block = block
	end

	def eval()
		instance_eval(&@block)
	end
	
	def img(path, md5)
		puts "#{path} \t #{md5}"
	end
	
	def html(path, str)
		puts "#{path} \t #{str}"
	end
end

#load 'dede.txt'
Find.do do
	img '/a.png', 'md5'
	html '/', 'str'
end
Find.do do
	img '/b.png', 'md5'
	if false then
	html '/cc/', 'str'
	end
end

Find.do()
