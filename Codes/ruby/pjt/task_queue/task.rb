#!/usr/bin/env ruby
require 'thread'
require "./mytask.rb"

task_queue = Queue.new
result_queue = Queue.new
mytask = Mytask.new("task.db")

task_thread = Thread.new do
  loop do
    mytask.list_origin.each do |item|
      puts "add task ===#{item}"
      task_queue.push(item)
      mytask.set_work(item[0])
    end
    sleep 1
  end
end

result_thread = Thread.new do
  loop do
  rx = result_queue.pop if result_queue.size > 0
    puts "complete task #{rx}" if !rx.nil?
    mytask.set_complete(rx[0]) if !rx.nil?
    sleep 1
  end
end

def task_thread(t,rq)
  Thread.new { 
    p "new thread  ===#{t.to_s}" 
    #`nmap -p 80 -v #{t[1]} > /tmp/#{t[1]}.del`
    `/root/Project/first/Codes/ruby/myruby/task_queue/subscan.rb #{t[0]}`
    rq.push(t) if !t.nil?
  }
end

loop do
  rt = task_queue.pop if task_queue.size > 0
  p "got task ===#{rt}" if !rt.nil?
  task_thread(rt,result_queue) if !rt.nil?
  sleep 1
end

task_thread.join
