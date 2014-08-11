
class Exploit_1 < FastExp

  def initialize
    @exp_id = 1
    @exp_name = "Teste Demo"
    @exp_type = "URL"
    @exp_txt = "Test exp get title"
    @pattern = /<title>.*<\/title>/
    @match = ""
    @found = false
  end

  def exp(type, arg)
    type.include?(@exp_type)
    html = HTTP.get("http://"+arg+"/index.php").to_s
    @match = @pattern.match html
    @found = true if @match != nil
  end

end

FastCfg+[Exploit_1.new]

