require 'nokogiri'
require 'pp'
require 'open-uri'

doc = Nokogiri::HTML.parse(<<-eohtml)
<html>
  <head>
    <title>Hello World</title>
  </head>
  <body>
    <h1>This is an awesome document</h1>

<form id="gaia_loginform" action="?" method="post">

<label>
  <strong class="email-label">用户名:</strong>
  <input name="username" value="" type="text">
</label>

<br><br>

<label>
  <strong class="passwd-label">密码:</strong>
  <input name="password"  type="password">

</label>
<input value="登录" type="submit">
<textarea name="comment" id="comment" tabindex="4" style="color: rgb(102, 102, 102);"></textarea> 
<select name="fmselect" id="type" tabindex="-1">
  <option value="1">提交BUG</option>
  <option value="2">产品建议</option>
  <option value="3">提交需求</option>
</select>
</form>

  </body>
</html>
eohtml

ret = {
id: nil,
action: nil,
method: nil,
data: [],
}

forms = doc.search('//form[@action]')

forms.each do |fm|
  #puts "#{fm.inspect}"
  #puts "#{fm.attributes}"

  #puts "form.name:   #{fm.name}"
  #puts "form.id:     #{fm.attributes['id']}"
  #puts "form.action: #{fm.attributes['action']}"
  #puts "form.method: #{fm.attributes['method']}"
  ret[:id] = fm.attributes['id'].value if fm.attributes['id']
  ret[:action] = fm.attributes['action'].value if fm.attributes['action'].value
  ret[:method] = fm.attributes['method'].value if fm.attributes['method'].value

  #puts "#{fm.children.inspect}"
  inputs = fm.children.search('//input')
  inputs.each do |input|
	#puts input.attributes['name'] if input.attributes['name']
	#puts input.inspect
	ret[:data] << input.attributes['name'].value if input.attributes['name']
  end

  inputs = fm.children.search('//select')
  inputs.each do |input|
	#puts input.attributes['name'] 
	#puts input.inspect
	ret[:data] << input.attributes['name'].value if input.attributes['name']
  end

  inputs = fm.children.search('//textarea')
  inputs.each do |input|
	#puts input.attributes['name']
	#puts input.inspect
	ret[:data] << input.attributes['name'].value if input.attributes['name']
  end

end

puts ret

