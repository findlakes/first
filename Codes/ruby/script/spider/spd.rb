#!/usr/bin/env ruby

require 'typhoeus'
require 'bloomfilter-rb'
require 'nokogiri'
require 'domainatrix'
require 'uri'

class Spider

		def initialize(url, options = {})
			@start_url = url
			@domain = parse_domain(url)
			@threads = options[:threads] ? options[:threads] : 200
			@max_urls = options[:max_urls] ? options[:max_urls] : nil
			@global_visited = BloomFilter::Native.new(:size => 10000000, :hashes => 5, :seed => 1, :bucket => 8, :raise => false)
			@global_queue = []
			@parse_queue = []
			@global_queue << @start_url
			@mux = Mutex.new
			@debug = options[:debug] ? options[:debug] : false
			@split_url_at_hash = options[:split_url_at_hash] ? options[:split_url_at_hash] : false
			@exclude_urls_with_hash = options[:exclude_urls_with_hash] ? options[:exclude_urls_with_hash] : true
			@exclude_urls_with_extensions = options[:exclude_urls_with_extensions] ? options[:exclude_urls_with_extensions] : false
		end

		def crawl(arg_queue)
			hydra = nil
			arg_queue.each do |q|
				begin
					hydra	= Typhoeus::Hydra.new(:max_concurrency => 1)
					request = Typhoeus::Request.new(q, :timeout => 5000)
					request.on_complete do |response|
						links = Nokogiri::HTML.parse(response.body).xpath('.//a/@href')
						links.each do |link|
							if(internal_link?(link, response.effective_url) && no_hash_in_url?(link) && ignore_extensions(link))
								sanitized_link = sanitize_link(split_url_at_hash(link))
								if(sanitized_link)
									absolute_link = make_absolute(sanitized_link, response.effective_url)
									@parse_queue << absolute_link if absolute_link
								end
							end
						end
					end
					hydra.queue request
			   rescue => e
					puts "Exception caught: #{e}" if @debug
			   end
			end
			#puts "arg_queue #{arg_queue.size} - parse_queue #{@parse_queue.size} - global_queue #{@global_queue.size}  -hydra_queue#{hydra.queued_requests.size}"
			hydra.run if hydra
		end

		def thread(n)
			count = 0
			q = nil
			while true
				begin
					if @parse_queue.size > 0 then
						@mux.synchronize do
						  q = @parse_queue.shift
						  if(q && !@global_visited.include?(q))
							yield q 
							@global_visited.insert(q)
							@global_queue << q
						  end
						end
						break if (!@max_urls.nil? && @global_visited.size.to_i > @max_urls)
						if @global_queue.size > 0 then
							crawl(@global_queue.shift(1)) 
							count = 0
						end
					else
						sleep 0.1
						count += 1
						#puts "thread #{n}  count: #{count}" if count == 200
						break if count == 500
					end
				rescue
					next 
				end
			end
		end

		def run()
			crawl(@global_queue.shift(5))
			thread_list = []
			@threads.times do |n| 
				puts("Checks thread #{n} start.") if @debug
				thread_list[n] = Thread.new{ thread(n) do |i| yield i end  }
			end 
			thread_list.each do |t| t.join end
		end

		def parse_domain(url)
				puts "Parsing URL: #{url}" if @debug
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
		
		def internal_link?(url, effective_url)
	
			absolute_url = make_absolute(url, effective_url)
	
			parsed_url = parse_domain(absolute_url)
			if(@domain == parsed_url)
				return true
			else
				return false
			end
		end
	
		def split_url_at_hash(url)
			return url.to_s unless @split_url_at_hash
	
			return url.to_s.split('#')[0]
	
		end
	
		def no_hash_in_url?(url)
			return true unless @exclude_urls_with_hash
	
			if(url.to_s.scan(/#/).size > 0 || url.to_s.end_with?('?') )
				return false
			else
				return true
			end
		end
	
		def ignore_extensions(url)
			return true if url.to_s.length == 0
			return true unless @exclude_urls_with_extensions
	
			not_found = true
	
			@exclude_urls_with_extensions.each do |e|
				if(url.to_s.length > e.size && url.to_s[-e.size .. -1].downcase == e.to_s.downcase)
					not_found = false
					puts "#{e} Found At URL: #{url}" if @debug
				end
			end
	
			return not_found
		end
	
		def sanitize_link(url)
			begin
				return url.gsub(/\s+/, "%20")
			rescue
				return false
			end
		end
	
		def make_absolute( href, root )
	
			begin
				URI.parse(root).merge(URI.parse(split_url_at_hash(href.to_s.gsub(/\s+/, "%20")))).to_s
			rescue URI::InvalidURIError, URI::InvalidComponentError => e
				return false
			end
		end
end

if $0 == __FILE__

	exit if !ARGV[0]
	lino = 0
	exts = ['exe', 'rar', 'zip', 'tar', 'tgz', 'gz', 'jpg', 'png', 'gif']
	Spider.new(ARGV[0], {:exclude_urls_with_extensions => exts}).run() do |response|
	  lino += 1
	  puts "#{lino} - #{response}"
	end

end
