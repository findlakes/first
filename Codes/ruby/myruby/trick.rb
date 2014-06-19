require 'pp'

#Pretty Print
items=[1,2,3]
pp items

#Print var type
puts items.class

=begin
block comment
=end

#Ruby inner variable
http://shouce.jb51.net/ruby/81.html

:foo is a symbol named "foo". Symbols have the distinct feature that any two symbols named the same will be identical:
"foo".equal? "foo"  # false
:foo.equal? :foo    # true
