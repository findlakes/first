require 'nokogiri'
require 'pp'
require 'open-uri'

# baidu spider
10.times do |i|

  page = "#{i}0"
  doc = Nokogiri::HTML(open("http://www.baidu.com/s?wd=ceshi&pn=#{page}"))
  doc.search('span.g').each do |link|
    ret = link.content.scan(/(.*)\//)
    puts ret
  end

end
