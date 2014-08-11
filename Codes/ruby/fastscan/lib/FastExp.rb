
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
  end

  def exp_id
    @exp_id
  end

  def found?
    @found
  end

  def to_json
    {
    "exp_id"=>@exp_id,
    "exp_name"=>@exp_name,
    "exp_txt"=>@exp_txt,
    "pattern"=>@pattern,
    "match"=>@match,
    "found"=>@found
    }.to_json
  end

  def to_s
    to_json
  end

end
