# each_byte 
"abc".each_byte{|c| printf "<%c>", c}; print "\n"

s="abc";i=0
while i<s.length
  printf "<%c>", s[i]; i+=1
end; print "\n"

# earch_line
"a\nb\nc\n".each_line{|l| print l}

# retry
c=0
for i in 0..4
  print i
  if i == 2 and c == 0
    c = 1
    print "\n"
    retry
  end
end; print "\n"
#012
#01234

# redo
c=0
for i in 0..4
  print i
  if i==2 and c == 0
    c = 1
    print "\n"
    redo
  end
end; print "\n"
#012
#234
