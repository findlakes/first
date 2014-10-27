#!/usr/bin/env ruby
base = '/tmp/tmp/moni/'
other = '/public_html/Runtime/'
dirs = ['a','b','c']
dirs.each do |item|
  basepath = base+item
  otherpath = base+item+other
  `chown root.root #{ basepath } -R`
  `chown mysql.mysql #{ otherpath } -R`
end
