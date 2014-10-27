#!/usr/bin/env ruby

module Playload
	
	Thread_mtx = Mutex.new  
	Thread_num = 4 

	class Issue
		attr_accessor :name, :type, :tags, :description, :remedy_guidance
		attr_accessor :references, :severity, :is_found, :is_error
		def to_s() "#{@name} #{@type} #{@is_found} " end
		def exp() "Interface" end
	end
	
	class Queue
		@@List = []
		@@Result = []
		def self.all()    @@List              end
		def self.add(li)  @@List << li        end
		def self.remove() @@List.delete_at(0) end
		def self.result() @@Result            end
		def self.append(li) @@Result << li    end
	end

	def self.each()
		Queue.result.each do |item| yield item end
	end

	def self.run(url, debug=false)
		thread_list = []
		(0...Thread_num).each do |n|
			thread_list[n] = Thread.new do
				puts "Playload thread#{n} start." if debug
				Thread_mtx.lock
				while Queue.all.size > 0 do
					puts "Thread#{n} queue.size: #{Queue.all.size}" if debug
					item = Queue.remove 
					Thread_mtx.unlock
					puts "Exp run: " + item.name if debug
					item.exp(url)
					Queue.append item
				end
				puts "Playload thread#{n} stop." if debug
			end
		end
		thread_list.each do |t| t.join end
	end

	Dir[File.dirname(__FILE__)+"/exp/*.rb"].each{|exp| require(exp)}

end

if ["./playload.rb","playload.rb"].include?(__FILE__) then
	discuz_url = "http://www.zhhsw.com/"
	thinphp_url = "http://www.easy-aa.com/"
	dede_url = "http://www.ueloo.com/"
	Playload.run(dede_url, debug=true)
	Playload.each() do |issue| 
		puts "Issue detail: " + issue.to_s if issue.is_found
	end
end
