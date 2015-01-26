require 'webrick'

root = File.expand_path '/var/www/html'
server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root

trap 'INT' do server.shutdown end


server.mount_proc "/hello" do |req, res|
  res.body = 'Hello, world!'
end

server.start
