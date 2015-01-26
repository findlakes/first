# Arrays
ary = [1, 2, "3"]
puts ary

ary = ary + ["foo", "bar"]
puts ary

ary = ary * 2
puts ary


puts ary[0]
puts ary[0,2]
puts ary[0..1]
puts ary[-2]
puts ary[-2,2]
puts ary[-2,-1]

str = ary.join(":")
puts str

puts str.split(":")

# Hashes
h = {1=>2, "2"=>"4"}
puts h
puts h[1]
puts h["2"]
puts h[5]
h[5]=10
puts h[5]

h.delete 1
puts h
