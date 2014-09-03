
class Exploit_1 < FastExp

  def initialize
    @exp_id = 1
    @exp_name = "Base URL Access Check."
    @exp_type = "HOST"
  end

  def exp(type, arg)
	begin
    	return if !type.include?(@exp_type)
    	html = HTTP.get("http://"+arg+"/").to_s
    	@found = true if html.size > 0
	rescue
		@error = true
		@error_info = "error:#{$!} at:#{$@}"
	end
  end

end

FastCfg+[Exploit_1.new]

