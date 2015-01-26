
require 'nokogiri'
require 'typhoeus'
require 'iconv'

# demo1
#doc = Nokogiri::HTML.parse(open("http://www.hao123.com/"), nil, "UTF-8")

# demo2
res  = Typhoeus.get("http://www.sina.com.cn")
body = res.body
charset = body.scan(/charset="?([^\s"]*)/i).first.join
p charset
p body.encoding
    if !charset.nil? and !charset.empty?
	  #body =Iconv.iconv("UTF-8", charset, body).join
      body =Iconv.iconv("UTF-8//IGNORE", charset.upcase+'//IGNORE', body).join
      #body.encode("UTF-8", replace: nil)
    else
      body.force_encoding("ASCII-8BIT").encode("utf-8", replace: nil)
    end
p body.encoding

# demo3
doc = Nokogiri::HTML.parse(body,nil,"UTF-8")
p doc.title

