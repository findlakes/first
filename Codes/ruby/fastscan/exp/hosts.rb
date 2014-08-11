
class Exploit_6 < FastExp

  def initialize
    @exp_id = 6
    @exp_name = "Hosts scan"
    @exp_type = "HOST"
    @exp_txt = "Hosts scan list"
    @pattern = //
    @match = ""
    @found = false
  end

  def exp(type, arg)
    return if !type.include?(@exp_type)
    arg = arg[4..-1] if arg.start_with? "www."
    File.open("res/hosts.txt") do |file| 
      file.each do |line|
        domain = line.chop+"."+arg
        ipa = Resolv.getaddresses(domain)
        if ipa.size > 0
          head = HTTP.head("http://"+domain+"/")
          if head.status == 200
            @match = @match + line.chop + "; "
          end
        end
      end 
    end 
    @found = true if @match.size > 0
  end

end

FastCfg+[Exploit_6.new]

