class A
  def initialize
    @a=0;@c=3
  end
  attr_accessor :a, :c, :b
end

a = A.new

ins_vars = a.instance_variables.map{|v|v.to_s[1..-1]}
methods = a.methods.map &:to_s
puts ins_vars 
#puts methods #attribute

