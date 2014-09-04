
class Exploit_6 < FastExp

  def initialize
    @exp_id = 6
    @exp_name = "Submains Scan"
    @exp_type = "HOST"
	@match = ""
  end

  def exp(type, arg)
	begin
    	return if !type.include?(@exp_type)
    	arg = arg[4..-1] if arg.start_with? "www."
    	File.open("Res/hosts.txt") do |file| 
    	  file.each do |line|
    	    domain = line.chop+"."+arg
    	    begin
    	      ipa = Resolv.getaddresses(domain)
    	      if ipa.size > 0
    	        head = HTTP.head("http://"+domain+"/")
    	        if head.status == 200
    	          @match = @match + line.chop + "; "
    	        end
    	      end
    	    rescue
    	      next
    	    end
    	  end 
    	end 
    	@found = true if @match.size > 0
	rescue
		@error = true
		@error_info = "error:#{$!} at:#{$@}"
	end
  end

end

FastCfg+[Exploit_6.new]

