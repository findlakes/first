require 'rubygems'
require 'mechanize'

agent = Mechanize.new

page = agent.get('http://www.lol.com/b.php')

page.links.each do |link|
  puts link.inspect
end

test_index = 0

form = page.form()

form.fields.each_with_index do |field, index|

	if test_index == index
		field.value='payload'
	else
		field.value='testit'
	end

end
#puts form.inspect

ret = agent.submit(form)
puts ret.body
