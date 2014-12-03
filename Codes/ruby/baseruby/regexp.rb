# contains hex in

puts "abcdef" =~ /d/
puts "aaaaaa" =~ /d/

def chab(s)
  (s =~ /<0(x|X)(\d|[a-f]|[A-F])+>/) != nil
end

puts chab "Not this one."
puts chab "maybe {0x35}"
puts chab "this <0xfc004>"


################################################
st = "\033[7m"
en = "\033[m"

puts "Enter an empty string at any time to exit."

while true
  print "str> "; STDOUT.flush; str=gets.chop
  break if str.empty?
  print "pat> "; STDOUT.flush; pat=gets.chop
  break if pat.empty?
  re=Regexp.new(pat)
  puts str.gsub(re, "#{st}\\&#{en}")
end

#str> foobar
#pat> ^fo+
#foobar
#str> abc012dbcd555
#pat> \d
#abc012dbcd555
#str> foozboozer
#pat> f.*z
#foozboozer
#str> Wed Feb  7 08:58:04 JST 1996
#pat> [0-9]+:[0-9]+(:[0-9]+)?
#Wed Feb  7 08:58:04 JST 1996

