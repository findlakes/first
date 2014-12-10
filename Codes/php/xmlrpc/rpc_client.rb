
require "xmlrpc/client"

# Make an object to represent the XML-RPC server.
server = XMLRPC::Client.new( "localhost", "/xmlrpc/rpc_server.php")

# Call the remote server and get our result
result = server.call("say_hello", 'evan', [1,2])

puts result.to_s

