
class Exploit_7 < FastExp

  def initialize
    @exp_id = 7
    @exp_name = "Dirs scan"
    @exp_type = "DIR"
    @exp_txt = "Dirs scan list"
    @pattern = //
    @match = ""
    @found = false
  end

  def exp(type, arg)
    return if !type.include?(@exp_type)
    File.open("res/test.dict") do |file| 
      file.each do |line|
        head = HTTP.head("http://"+arg+"/"+line.chop)
        if head.status == 200
          @match = @match + line.chop + "; "
        end
      end 
    end 
    @found = true if @match.size > 0
  end

end

FastCfg+[Exploit_7.new]

