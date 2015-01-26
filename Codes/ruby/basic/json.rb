require 'json'
require 'pp'
require './single'

file = File.read('discuz_7_2_sqli.json')

data_hash = JSON.parse(file)

data_hash.each do |hash|

  action = hash['class']
  case action
  when 'single'
    Single.new hash
  else
    puts "Action[#{action}] not found."
  end

end
#pp data_hash
