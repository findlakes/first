#
# Module:
# Network Detection.
#

module Detection

	MODULE_NAME = "Network Detection"

	def self.run()
		# Module Start.
		$glb.log.info("Module START #{MODULE_NAME}...")

		# Detect Access
		self.detect_server

		# Detect Port
		thread_port = Thread.new { self.detect_port() }

		# Detect WEB Server
		thread_group1 = [] 
		(0...$glb.data["WEB_INFO"]["array"].size).each do |n|
			$glb.log.info("#{$glb.data["WEB_INFO"]["array"][n]["desc"]} Start ...")
			thread_group1[n] = Thread.new { self.detect_head2($glb.data["WEB_INFO"]["array"][n]) }
		end

		# Detect Backup Info
		thread_group2 = [] 
		(0...$glb.data["BACK_INFO"]["array"].size).each do |n|
			$glb.log.info("#{$glb.data["BACK_INFO"]["array"][n]["desc"]} Start ...")
			thread_group2[n] = Thread.new { self.detect_head2($glb.data["BACK_INFO"]["array"][n]) }
		end

		# Detect Login Info
		thread_group3 = [] 
		(0...$glb.data["LOGIN_INFO"]["array"].size).each do |n|
			$glb.log.info("#{$glb.data["LOGIN_INFO"]["array"][n]["desc"]} Start ...")
			thread_group3[n] = Thread.new { self.detect_head2($glb.data["LOGIN_INFO"]["array"][n]) }
		end

		# Detect Backdoor Info
		thread_group4 = [] 
		(0...$glb.data["DOOR_INFO"]["array"].size).each do |n|
			$glb.log.info("#{$glb.data["DOOR_INFO"]["array"][n]["desc"]} Start ...")
			thread_group4[n] = Thread.new { self.detect_head2($glb.data["DOOR_INFO"]["array"][n]) }
		end

		# Wait for threads
		thread_port.join
		thread_group1.each { |t| t.join }
		thread_group2.each { |t| t.join }
		thread_group3.each { |t| t.join }
		thread_group4.each { |t| t.join }

		# Module Stop.
	end

	def self.detect_server()
		$glb.log.info("#{$glb.data["SERVER_INFO"]["desc"]} Start...")
		list = []
		begin
			Net::HTTP.start($glb.host, $glb.port) do |http|
				response = http.request_get('/', {"Cookie"=>$glb.set_cookie, "User-Agent"=>$glb.user_agent})
				list += [{"code"=>response.code}, {"http_version"=>response.http_version}, {"message"=>response.message} ]
				response.header.each_header {|key,value| list += [{"#{key}"=>"#{value}"}] }
			end
		rescue SocketError
			$glb.log.error("SocketError Can't Connet to #{@first_uri}")
			exit
		rescue Errno::ECONNRESET
			$glb.log.error "CONN RESET by peer:  #{@ip}"
			exit
		end
		$glb.data["SERVER_INFO"]["list"] = list
		$glb.log.warn(list)
	end

	def self.detect_head(item)
		File.open('res/'+item['file']) do |file| 
			file.each do |line|
				begin
					Net::HTTP.start($glb.host, $glb.port) do |http|
						response = http.request_head(line.chop, {"Cookie"=>$glb.set_cookie, "User-Agent"=>$glb.user_agent})
						item['list'] += [line.chop] if response.code == "200"
					end
				rescue
					next
				end
			end 
		end 
		$glb.log.info(item["desc"] + " Stop ...")
		$glb.log.warn(item["list"])
	end

	def self.detect_head2(item)
		Net::HTTP.start($glb.host, $glb.port) do |http|
			File.open('res/'+item['file']) do |file| 
				file.each do |line|
					begin
						response = http.request_head(line.chop, {"Cookie"=>$glb.set_cookie, "User-Agent"=>$glb.user_agent})
						item['list'] += [line.chop] if response.code == "200"
					rescue
						next
					end
				end
			end 
		end 
		$glb.log.info(item["desc"] + " Stop ...")
		$glb.log.warn(item["list"])
	end

	def self.detect_port()
		$glb.log.info("#{$glb.data["PORT_INFO"]["desc"]} Start...")
		list = []
		$glb.data["PORT_INFO"]["ports"].each do |port|
			begin
				sock = Socket.new(:INET, :STREAM)
				raw = Socket.sockaddr_in(port, $glb.ip)
				list += [port] if sock.connect(raw)
			rescue
				sock.close if sock != nil
	    	end 
		end
		$glb.data["PORT_INFO"]["list"] = list
		$glb.log.warn("Port Found: #{list}")
	end

end

