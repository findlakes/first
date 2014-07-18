
class Exploit_2 < FastExp

  def initialize
    @exp_id = 2
    @exp_type = "URL"
    @exp_txt = "robots.txt infomations"
    @pattern = /[^\r\n]+(admin|manage)[^\r\n]+/
    @match = ""
    @found = false
  end

  def exp(type, arg)
    type.include?(@exp_type)
    html = HTTP.get("http://"+arg+"/robots.txt").to_s
    #@match = html.scan(@pattern)
    @match = @pattern.match html
    @found = true if @match != nil
  end

end

FastCfg+[Exploit_2.new]

