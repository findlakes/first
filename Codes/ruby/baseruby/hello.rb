#!/usr/bin/env ruby
# exec ruby hello.rb

def h
puts "Hello World"
end
puts "\nDemo1:"
h()
####################

def h2(name)
puts "Hello #{name.capitalize}"
end
puts "\nDemo2:"
h2("evan")
####################

class Dog
  def initialize(name = "World")
    @name = name
  end
  def say_hi
    puts "Hi #{@name}!"
  end
  def say_bye
    puts "Bye #{@name}!"
  end
end
puts "\nDemo3:"
g = Dog.new("WangWang")
g.say_hi()
g.say_bye()
puts Dog.instance_methods(false)
puts g.respond_to?("say_hi")
####################


puts "\nDemo4:"
class XDog
  attr_accessor :names
  def initialize(names = "World")
    @names = names
  end
  def say_hi
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
      @names.each do |name|
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}!"
    end
  end
  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      puts "Goodbye #{@names.join(",")}. Come back soon!"
    else
      puts "Goodbye #{@names}. Come back soon!"
    end
  end
end

if __FILE__ == $0
  mg = XDog.new
  mg.say_hi
  mg.say_bye

  mg.names = "Zeke"
  mg.say_hi
  mg.say_bye

  mg.names = ["aaa", "bbb", "ccc"]
  mg.say_hi
  mg.say_bye

  mg.names = nil
  mg.say_hi
  mg.say_bye
end
