#!/usr/bin/env ruby

require 'logger'
require 'json'
require 'resolv'
require 'pp'
#gem install http
require "http"
require 'thread'

# load config
require File.absolute_path('./Lib/FastCfg.rb')
require File.absolute_path('./Lib/FastExp.rb')


#exit if ARGV.size < 1
#domain = ARGV[0]
def main(arg_type, arg_str)

domain = arg_str
# exploit type
#exp_type = ["URL","HOST","DIR"]
exp_type = arg_type
# exploits script
exploits = Dir["./Exp/*.rb"]
# load exploits
exploits.each do |exp|
  require(exp)
end

thread_num = 4
thread_list = []
expIsFound = false

(0..thread_num).each do |n|

  length = FastCfg.list.size / (thread_num - 1) if FastCfg.list.size != 0
  exp_group = FastCfg.list[n*length,length]

  thread_list[n] = Thread.new do
    FastCfg.debug("Thread #{n} start...")
    exp_group.each do |i|
        FastCfg.info "Start Exp: #{i.exp_id} #{i.exp_name}"
        i.exp(exp_type, domain)
        FastCfg.debug i if i.found?
        FastCfg.error i.error_info if i.error?
        FastCfg.match i.match_info if i.found?
    end if !exp_group.nil?
  end

end

thread_list.each do |t| t.join end
end

#main("HOST","localhost")
