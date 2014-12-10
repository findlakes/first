
require "xmlrpc/server"

s = XMLRPC::CGIServer.new

s.add_hanlder("sample.sumAndDifference") do |a,b|
  { "sum" => a + b, "difference" => a - b }
end

s.serve

