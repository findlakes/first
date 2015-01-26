require 'net/http'
require 'iconv'


def utf2gbk(str)
	Iconv.new('gbk','utf-8' ).iconv(str)  
end

def gbk2utf(str)
	Iconv.new('utf-8' ,'gbk').iconv(str)  
end

def gettitle(res)
	res_charset = res.body[/<meta.*\s*charset=\s*('|")*utf-8/i]
	#debug -> puts res_charset
	res_title = res.body[/<title>.*<\/title>/]
	res_title = res_title[7...-8] if res_title != nil
	# Windows Charset
	#res_title = utf2gbk(res_title) if res_charset != nil
	# Linux Charset
	res_title = gbk2utf(res_title) if res_charset == nil
	res_title
end

def getinfo(uris)
  begin
	uri = URI(uris)
	res = Net::HTTP.get_response(uri)
	res_title = gettitle(res) if res.body != nil
	[res.code, res.msg, res_title]
  rescue
	puts "Request failed : #{uris}  #{$!}"
  end
end

def fetch(glossary, domain)
  glossary.each do |priname|
	var1 = 'http://'+priname+domain+'/'
	info = getinfo(var1)
	puts var1 + ' '  + info.join(' ') if info != nil
  end
end

target='.baidu.com'  #.tengshui.com
glossary1=['www','mail','bbs']
glossary2=['www1','admin','email']
glossary3=['test','sys','blog']


thr1 = Thread.new { puts "thr1 start."; fetch(glossary1, target) }
thr2 = Thread.new { puts "thr2 start."; fetch(glossary2, target) }
thr3 = Thread.new { puts "thr3 start."; fetch(glossary3, target) }
thr1.join
thr2.join
thr3.join
puts "Threads End..."


