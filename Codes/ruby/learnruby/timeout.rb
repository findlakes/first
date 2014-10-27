
require 'timeout'

begin
status = Timeout::timeout(1) {
  puts 123 
  sleep(3)
  puts 456
}
rescue Timeout::Error => e

	puts "hah"

end
