require 'json'
require 'pp'
require './module/single'

class Load

  def initialize()
    @json_dir =  File.dirname(__FILE__)
    @json_dir += "/json/*.json"

    @file_ary =  []
    @hash_ary =  []

    load_file()
    load_hash()
    dispatch()
  end

  def load_file()
    Dir[@json_dir].each do |file| 
      @file_ary << file
    end
  end

  def load_hash()
    @file_ary.each do |file|
      json = File.read(file)
      hary  = JSON.parse(json)
      hary.each do |ary|
        @hash_ary << ary
      end
    end
  end

  def dispatch()
    @hash_ary.each do |hash|
      action = hash['class']
      case action
      when 'single'
        Single.new hash
      else
        puts "Action[#{action}] not found."
      end
    end
  end

end

if $0 == __FILE__
  Load.new
end

