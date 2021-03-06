require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML.parse(<<-eohtml)
<html>
  <head>
    <title>Hello World</title>
  </head>
  <body>
    <h1>This is an awesome document</h1>
    <p>
      I am a paragraph
        <a href="http://google.ca">I am a link</a>
        <a href="http://google.ca">I am a link</a>
    </p>
  </body>
</html>
eohtml

doc.search('//p/a', 'p > a').each do |a_tag|
  puts a_tag.content
end

tag = doc.search( '//a[@href]' ).map { |a| a['href'] }
p tag.to_s

