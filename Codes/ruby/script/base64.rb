require 'open-uri'
require 'nokogiri'
require "base64"
require 'pp'

body = '''
<div class="container">
    <h1>建站类组件库列表(共计627条) <a href="/info/libraryfull">查看所有列表</a></h1>
      <h2>网站模块</h2>
        <a href="/search/result?qbase64=aGVhZGVyPSJtb2Rfamsi%0A">mod_jk</a>， 
        <a href="/search/result?qbase64=aGVhZGVyPSJtb2RfcGVybCI%3D%0A">mod_perl</a>， 
        <a href="/search/result?qbase64=aGVhZGVyPSJtb2Rfd3NnaSI%3D%0A">mod_wsgi</a>， 
    <p>
<div>
'''
#doc = Nokogiri::HTML(body)

ret = []
type = ''
base = ''
patn = ''
row = {}

doc = Nokogiri::HTML(open("http://fofa.so/info/library"),nil,"UTF-8")

c = doc.search('.container')
c.children.each do |i|
  if i.name == 'h2'
    type = i.children.to_s
    #puts "\n+++ #{type}+++"
    row['name'] = type
    row['list'] = Array.new
    ret << row.clone
  elsif i.name == 'a'
    base = i.children.to_s
    patn = Base64.decode64(URI.unescape(i.attributes['href'].value[23..-1])).force_encoding('UTF-8')
    #puts "#{base} #{patn}"
    #puts ""
    row['list'] << {base: base, patn:patn}
  end
end

pp ret

