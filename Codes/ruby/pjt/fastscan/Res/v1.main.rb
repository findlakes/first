#!/usr/bin/env ruby

require 'logger'
require 'json'
require 'resolv'
require 'pp'
#gem install http
require "http"
require 'thread'
require File.absolute_path('./lib/FastCfg.rb')
require File.absolute_path('./lib/FastExp.rb')

# exploit type
#exp_type = ["URL","DIR"]
exp_type = ["URL","HOST","DIR"]
# exploits script
exploits = Dir["./exp/*.rb"]

# load exploits
exploits.each do |exp|
  require(exp)
end

=begin
# execute exp
FastCfg.list.each do |item|
  begin
  item.exp(exp_type,"www.discuz.net")
  puts item if item.found?
  rescue
    puts "Exceptions... exp_id: #{item.exp_id}"
  end
end
=end

#domain = "www.fastweb.com.cn"
# test exp 2
#domain = "www.discuz.net"
# test exp 3
#domain = "www.ytjt.com.cn"
#domain = "test.jdyt.cn"
# test exp 4 
#domain = "www.zhhsw.com"
# test exp 5
#domain = "www.ueloo.com"

thread_num = 4
thread_list = []
expIsFound = false

(0..thread_num).each do |n|

  length = FastCfg.list.size / 3 if FastCfg.list.size != 0
  fast_exp = FastCfg.list[n*length,length]

  thread_list[n] = Thread.new do
    FastCfg.info("Thread #{n} start...")
    fast_exp.each do |i|
      #begin
        FastCfg.info "exp: #{i.exp_id} start #{i.exp_name}"
        i.exp(exp_type, domain)
        FastCfg.debug i if i.found?
        FastCfg.error i.error_info if i.error?
      #rescue
      #  puts "Exception!!! Exp_Id: #{i.exp_id}"
      #end
    end if !fast_exp.nil?
  end

end

thread_list.each do |t| t.join end

