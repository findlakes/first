#!/usr/bin/env ruby
#
# Main:
#
require 'uri'
require 'logger'
require 'net/http'
require 'socket'
require 'resolv'
require 'pp'


require("./module/Detection.rb")
require("./module/Identification.rb")
require("./module/Collection.rb")
require("./module/Traverse.rb")
require("./class/Log.rb")
require("./class/Global.rb")
require("./class/Dataset.rb")


$glb            = Global.new("http://localhost:80/")
$glb.user_agent = "Opera/9.27 (Windows NT 5.2; U; zh-cn)"
$glb.set_cookie = "-"
$glb.log        = Log.new
$glb.data       = $dataset
$glb.log.debug  "Print Glocal: #{$glb}"

thread_detect	= Thread.new { Detection.run() }
#thread_identify	= Thread.new { Identification.run(global) }
#thread_collect	= Thread.new { Collection.run(global) } 
#thread_traverse	= Thread.new { Traverse.run(global) } 

thread_detect.join
#thread_identify.join
#thread_collect.join
#thread_traverse.join 
#

#pp $glb.data
#
