#!/usr/bin/env ruby

require 'poseidon'

# earliest_offset latest_offset
consumer = Poseidon::PartitionConsumer.new("my_test_consumer", "localhost", 9092,
                                            "topic1", 0, :earliest_offset)
loop do
  messages = consumer.fetch
  messages.each do |m|
    puts m.value
  end
end
