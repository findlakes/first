
class FastExp

  @@logger = Logger.new(STDOUT)

  def initialize()
    @exp_id = 0
    @exp_name = ""
    @exp_type = ""
    @exp_txt = ""
    @pattern = //
    @match = ""
    @found = false
	@error = false
	@error_info = ""
  end

  def error?
    @error
  end

  def error_info
	"Exp ID: " + @exp_id.to_s + " NAME: " + @exp_name + " INFO: " + @error_info.to_s
  end

  def match_info
	"Exp ID: " + @exp_id.to_s + " NAME: " + @exp_name + " INFO: " + @match.to_s
  end

  def exp_id
    @exp_id
  end

  def exp_name
    @exp_name
  end

  def found?
    @found
  end

  def to_json
    {
    "exp_id"=>@exp_id,
    "exp_name"=>@exp_name,
    "exp_type"=>@exp_type,
    "exp_txt"=>@exp_txt,
    "pattern"=>@pattern,
    "match"=>@match.to_s.encode("ASCII-8BIT", "UTF-8", :invalid => :replace, :undef => :replace, :replace => "?"),
    "found"=>@found,
    "error"=>@error,
    "error_info"=>@error_info
    }.to_json
  end

  def to_s
    to_json
  end

end
