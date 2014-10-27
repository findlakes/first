require 'nokogiri'
require 'open-uri'

if $0 == __FILE__
  word = ARGV[0] || "baidu keyword"
  #while true do
  #  word = (0...6).map{ ('a'..'z').to_a[rand(8)] }.join
    2.times do |i|
      page = "#{i}0"
      doc = Nokogiri::HTML(open("http://www.baidu.com/s?wd=#{word}&pn=#{page}"))
      doc.search('span.g').each do |link|
        ret = link.content.scan(/(.*)\//)
        puts "word:#{word} - page_#{i} : #{ret}"
      end
    end
  #  sleep 20
  #end
end
