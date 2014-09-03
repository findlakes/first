#!/usr/bin/env ruby

require 'poseidon'

exit if ARGV.size < 1
my_url = ARGV[0]
producer = Poseidon::Producer.new(["localhost:9092"], "my_test_producer")
messages = []
messages << Poseidon::MessageToSend.new("topic1", my_url)
producer.send_messages(messages)
sleep 1
