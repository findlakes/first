require 'net/http'
require 'iconv' 

def gettitle(res)
	res_charset = /<meta.*\s*charset=\s*('|")*(utf-8)/i.match(res.body)
	res_charset =  res_charset[2].downcase if !res_charset.nil?
	res_title = /<title>(.*)<\/title>/.match(res.body)
	res_title = res_title[1] if !res_title.nil?
	# res_title = Iconv.new('gbk','utf-8').iconv(res_title) if res_charset == 'utf-8' # Windows Charset
	res_title = Iconv.new('utf-8','gbk').iconv(res_title) if res_charset != 'utf-8'   # Linux Charset
	res_title
end

def getinfo(uris)
  begin
	uri = URI(uris)
	res = Net::HTTP.get_response(uri)
	res_title = gettitle(res) if res.body != nil
	[res.code, res.msg, res_title]
  rescue
	puts "Request failed. #{$!}"
  end
end

domain1='.baidu.com'
domain2='.tengshui.com'
glossary=['www','mail','bbs']

glossary.each do |priname|
	var1 = 'http://'+priname+domain2+'/'
	info = getinfo(var1)
	puts info.join(' ') if info != nil
end
