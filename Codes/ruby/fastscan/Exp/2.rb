
class Exploit_2 < FastExp

  def initialize
    @exp_id = 2
    @exp_name = "Robots Check"
    @exp_type = "HOST"
    @exp_txt = "robots.txt infomations"
    @pattern = /[^\r\n]+(admin|manage)[^\r\n]+/
  end

  def exp(type, arg)
	begin
		return if !type.include?(@exp_type)
    	html = HTTP.get("http://"+arg+"/robots.txt").to_s
    	@match = @pattern.match html
    	@found = true if @match != nil
	rescue
		@error = true
		@error_info = "error:#{$!} at:#{$@}"
	end
  end

end

FastCfg+[Exploit_2.new]

