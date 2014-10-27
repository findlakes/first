require 'socket' #socket library
require 'resolv'

 
def open_port(host)
	ip = Resolv.getaddress(host)
	ip = "127.0.0.1" if host == "localhost"
	[21,22,23,25,80,443,3306,3389,1433,1521,8080].each do |port|
	begin
		sock = Socket.new(:INET, :STREAM)
		raw = Socket.sockaddr_in(port, ip)
		puts "#{port} open." if sock.connect(raw)
	rescue
		if sock != nil
			sock.close
		end
    end 
	end
end

#open_port("http://www.baidu.com/") 


	ip = Resolv.getaddress("http://www.baidu.com/")
puts ip
