require 'thread'
require "./mytest.rb"

task_queue = Queue.new
result_queue = Queue.new
mytask = Mytask.new("a.db")

task_thread = Thread.new do
  mytask.get_origin.each do |item|
    puts "add a task #{item["domain"]}"
    sleep 1
  end
end

task_thread.join
