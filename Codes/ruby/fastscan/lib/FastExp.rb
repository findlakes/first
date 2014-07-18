require 'logger'

class FastExp

  @@logger = Logger.new(STDOUT)

  def initialize()
    @exp_id = 0
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

  def to_s
    "{\n exp_id: #{@exp_id}, \n exp_type: #{@exp_type}\n exp_txt: #{@exp_txt},\n pattern: #{@pattern},\n match: #{@match},\n found: #{@found}  \n}"
  end

end
