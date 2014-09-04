require 'logger'
require(File.absolute_path('./Lib/FastExp.rb'))

class FastCfg

  @@fast_exploit=[]
  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::INFO

  def self.list
    @@fast_exploit
  end

  def self.+ (x)
    @@fast_exploit = @@fast_exploit + x
  end

  def initialize()
  end

  def self.error(msg)
    @@logger.error "\e[41m#{msg}\e[0m"
  end

  def self.debug(msg)
    @@logger.debug "\e[33m#{msg}\e[0m"
  end

  def self.match(msg)
    @@logger.info "\e[32m#{msg}\e[0m"
  end

  def self.info(msg)
    @@logger.info msg
  end

end
