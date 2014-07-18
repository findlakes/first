require 'logger'
require(File.absolute_path('./lib/FastExp.rb'))

class FastCfg

  @@fast_exploit=[]
  @@logger = Logger.new(STDOUT)

  def self.list
    @@fast_exploit
  end

  def self.+ (x)
    @@fast_exploit = @@fast_exploit + x
  end

  def initialize()
  end

  def self.level()
    @@logger.level = Logger::DEBUG
  end

  def self.error(msg)
    level()
    @@logger.error msg
  end

  def self.debug(msg)
    level()
    @@logger.debug msg
  end

  def self.info(msg)
    level()
    @@logger.info msg
  end

end
