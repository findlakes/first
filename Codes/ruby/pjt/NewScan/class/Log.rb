class Log

	@@logger = Logger.new(STDOUT)
	@@logger.level = Logger::DEBUG

	def error(msg)
		@@logger.error "\e[41m#{msg}\e[0m"
	end

	def warn(msg)
		@@logger.warn "\e[32m#{msg}\e[0m"
	end

	def debug(msg)
		@@logger.debug "\e[33m#{msg}\e[0m"
	end

	def info(msg)
		@@logger.info msg 
	end

end
