#
# Class: Global
#

class Global

	attr_accessor :first_uri
	attr_accessor :ip
	attr_accessor :host
	attr_accessor :port
	attr_accessor :user_agent
	attr_accessor :set_cookie
	attr_accessor :log
	attr_accessor :data

	def to_s
		"#{self.first_uri}, #{self.ip}, #{self.host}, #{self.port}, #{self.user_agent}, #{self.set_cookie}"
	end

	def initialize(arg_uri)
		begin
			@first_uri = arg_uri
			@first_uri = "http://" + @first_uri unless @first_uri.start_with?("http")
			uri = URI(@first_uri);
			@host = uri.host
			@port = uri.port
			@ip = Resolv.getaddress(uri.host)
			@ip = "127.0.0.1" if uri.host == "localhost"
		
		rescue Resolv::ResolvError
			$log.error "ResolvError Can't Resolv #{@host}"
			exit
		rescue URI::InvalidURIError
			$log.error "InvalidURIError:  #{@first_uri}"
			exit
		end
	end

end
