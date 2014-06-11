# ruby strings.rb

puts "a\nb\nc"
puts 'a\nb\nc'
puts '----------'

puts "\001"
puts '\001'
puts '----------'

puts "abcd #{2*3} efg"
var1 = " xxx "
puts "123#{var1}456"
puts '----------'

puts "foo" + "bar"
puts "foo"*2
puts '----------'

var2 = "fo"+"o"
var2 = var2*2
puts var2
puts var2[0]
puts var2[-1]
puts var2[0,1]
puts var2[-2,2]
puts var2[0..3]
puts var2[-5..-2]
puts '----------'

puts "foo" == "foo"
puts "foo" == "bar"
puts '----------'

words = ['aaa','bbb','ccc']
secret = words[rand(3)]
print "guess? "

while guess = STDIN.gets
  guess.chop!
  if guess == secret
    puts "You win!"
    break
  else
    puts "Sorry, you lose."
  end
  print "guess? "
end
puts "The word waf ", secret, "."
