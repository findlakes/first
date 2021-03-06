# encoding: utf-8

require 'typhoeus'
require 'bloomfilter-rb'
require 'nokogiri'
require 'domainatrix'
require 'uri'

class Arachnid

	def initialize(url, options = {})
		@start_url = url
		@domain = parse_domain(url)

		@split_url_at_hash = options[:split_url_at_hash] ? options[:split_url_at_hash] : false
		@exclude_urls_with_hash = options[:exclude_urls_with_hash] ? options[:exclude_urls_with_hash] : false
		@exclude_urls_with_extensions = options[:exclude_urls_with_extensions] ? options[:exclude_urls_with_extensions] : false
		@proxy_list = options[:proxy_list] ? options[:proxy_list] : false
		
		@debug = options[:debug] ? options[:debug] : false
	end

	def crawl(options = {})

		#defaults to 1 thread so people don't do a stupid amount of crawling on unsuspecting domains
		threads = options[:threads] ? options[:threads] : 1
		#defaults to -1 so it will always keep running until it runs out of urls
		max_urls = options[:max_urls] ? options[:max_urls] : nil

		@hydra = Typhoeus::Hydra.new(:max_concurrency => threads)
		@global_visited = BloomFilter::Native.new(:size => 1000000, :hashes => 5, :seed => 1, :bucket => 8, :raise => false)
		@global_queue = []

		@global_queue << @start_url
		
		while(@global_queue.size > 0 && (max_urls.nil? || @global_visited.size.to_i < max_urls))
			temp_queue = @global_queue

			temp_queue.each do |q|

				begin
					ip,port,user,pass = grab_proxy
 
					request = Typhoeus::Request.new(q, :timeout => 10000, :follow_location => true) if ip == nil
					request = Typhoeus::Request.new(q, :timeout => 10000, :follow_location => true, :proxy => "#{ip}:#{port}") if ip != nil && user == nil
					request = Typhoeus::Request.new(q, :timeout => 10000, :follow_location => true, :proxy => "#{ip}:#{port}", :proxy_username => user, :proxy_password => pass) if user != nil

					request.on_complete do |response|

						yield response

						links = Nokogiri::HTML.parse(response.body).xpath('.//a/@href')

						links.each do |link|
							if(internal_link?(link, response.effective_url) && !@global_visited.include?(make_absolute(link, response.effective_url)) && no_hash_in_url?(link) && ignore_extensions(link))
								
								sanitized_link = sanitize_link(split_url_at_hash(link))
								if(sanitized_link)

									absolute_link = make_absolute(sanitized_link, response.effective_url)
									if(absolute_link)
										@global_queue << absolute_link
									end
								end
							end
						end

					end

					@hydra.queue request

				rescue URI::InvalidURIError, NoMethodError => e
					puts "Exception caught: #{e}" if @debug == true
				end

				@global_visited.insert(q)
				@global_queue.delete(q)

			end

			@hydra.run

		end

	end

	def grab_proxy

		return nil unless @proxy_list

		return @proxy_list.sample.split(':')

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
		rescue NoMethodError, Addressable::URI::InvalidURIError => e
			puts "URL Parsing Exception (#{url}): #{e}"
			return nil
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

		if(url.to_s.scan(/#/).size > 0)
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
	no = 0
	exts = ['exe', 'rar', 'zip', 'tar', 'tgz', 'gz', 'jpg', 'png', 'gif']
	Arachnid.new(ARGV[0], {:exclude_urls_with_extensions => exts}).crawl({:threads => 200, :max_urls => nil}) do |response|
		no += 1
	    #"response" is just a Typhoeus response object.
	    puts "#{no} - #{response.effective_url}"
	
	end


end
