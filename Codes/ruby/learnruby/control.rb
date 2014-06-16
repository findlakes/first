# case

i=8
case i
when 1,2..5
  puts "1..5"
when 6..10
  puts "6..10"
end

case 'abcdef'
when 'aaa', 'bbb'
  puts 'aaa bbb'
when /def/
  puts "includes /def/"
end

# while ref regexp.rb
i = 0
puts "It's zero" if i==0
pust "It's negative" if i<0
puts i+=1 while i<3

# for
for num in (4..6)
  puts num
end

for elt in [100,-9.6,"abc"]
  puts "#{elt}\t(#{elt.class})"
end
