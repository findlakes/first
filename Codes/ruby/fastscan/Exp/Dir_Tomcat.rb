
class Exploit_102 < FastExp

  def initialize
    @exp_id = 102
    @exp_name = "Dir Tomcat Scan"
    @exp_type = "HOST"
	@match = ""
  end

  def exp(type, arg)
	begin
    	return if !type.include?(@exp_type)
    	File.open("Res/ApacheTomcat.fuzz.txt") do |file| 
    	  file.each do |line|
    	    head = HTTP.head("http://"+arg+"/"+line.chop)
    	    if head.status == 200
    	      @match = @match + line.chop + "; "
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

FastCfg+[Exploit_102.new]

