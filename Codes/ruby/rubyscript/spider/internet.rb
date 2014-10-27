#!/usr/bin/env ruby

require 'typhoeus'
require 'bloomfilter-rb'
require 'nokogiri'
require 'domainatrix'
require 'uri'

class Spider

		def initialize(url, options = {})
			@start_url = url
			@threads = options[:threads] ? options[:threads] : 200
			@max_urls = options[:max_urls] ? options[:max_urls] : nil
			@global_visited = BloomFilter::Native.new(:size => 10000000, :hashes => 5, :seed => 1, :bucket => 8, :raise => false)
			@global_queue = []
			@parse_queue = []
			@global_queue << @start_url
			@mux = Mutex.new
			@debug = options[:debug] ? options[:debug] : false
		end

		def crawl(arg_queue)

			hydra = nil
			arg_queue.each do |q|
				begin
					hydra	= Typhoeus::Hydra.new(:max_concurrency => 5)
					request = Typhoeus::Request.new(q, :timeout => 5000, :followlocation => true)
					request.on_complete do |response|
						links = Nokogiri::HTML.parse(response.body).xpath('.//a/@href')
						links.each do |link|
							parse = parse_domain(link.to_s)
							@parse_queue << parse if parse && parse != '.'
						end
					end
					hydra.queue request
			
			   rescue => e
					puts "Exception caught: #{e}" if @debug
			   end
			
			end
			hydra.run if hydra

		end

		def exp(url)
			u = 'http://'+url+'/.git/config'
			print('.')
			r = Typhoeus.get(u)
			if r
				body = r.body
				if body.include?('git') and body.include?('origin') then
					puts "=== #{u} ==="
					`/bin/echo #{u} >> ./log.txt`
				end
			end
		end

		def thread()
			count = 0
			qu = nil
			while(@max_urls.nil? || @global_visited.size.to_i < @max_urls)
			#while(@parse_queue.size > 0 && (@max_urls.nil? || @global_visited.size.to_i < @max_urls))
			begin
				@mux.synchronize do
					qu = @parse_queue.shift(5)
				end
				qu.each do |q|
				  if(!@global_visited.include?(q))
					yield q 
					@global_visited.insert(q)
					@global_queue << q
					#exp(q)
				  end
				end
				if @global_queue.size > 0 then
					crawl(@global_queue.shift(5)) 
					count = 0
				else
					sleep 0.1
					count += 1
					break if count == 1000
				end
			rescue
				next 
			end
			end
			puts("Checks thread stop.") if @debug
		end

		def run()
			crawl(@global_queue.shift(5))
			thread_list = []
			@threads.times do |n| 
				puts("Checks thread #{n} start.") if @debug
				thread_list[n] = Thread.new{ thread() do |i| yield i end  }
			end 
			thread_list.each do |t| t.join end
		end

		def parse_domain(url)
				#puts "Parsing URL: #{url}" if @debug
				begin
					parsed_domain = Domainatrix.parse(url)
					if(parsed_domain.subdomain != "")
							parsed_domain.subdomain + '.' + parsed_domain.domain + '.' + parsed_domain.public_suffix
					else
							parsed_domain.domain + '.' + parsed_domain.public_suffix
					end
				rescue
					nil
				end
		end

end

if $0 == __FILE__

	exit if !ARGV[0]
	lino = 0
	Spider.new(ARGV[0], {:debug => true}).run() do |response|
	  lino += 1
	  puts "#{lino} - #{response}"
	end

end
