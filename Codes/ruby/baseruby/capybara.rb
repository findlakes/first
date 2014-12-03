require 'capybara/dsl'
require 'capybara/poltergeist'

##### Demo: 1 ####
#include Capybara::DSL
#Capybara.javascript_driver = :poltergeist
#Capybara.current_driver = :poltergeist
#Capybara.default_driver = :poltergeist
#Capybara.app_host = "http://www.baidu.com"
#page.visit("http://demo.aisec.cn/demo/aisec/")

# 点击按钮
#buttons = page.all(:xpath, "//input[@type='button']")
#buttons.each do |btn| btn.click end

# 查找链接
#links = page.all(:xpath, "//a")
#links.each do |link|
#	puts link[:href]
#end
##################

##### Demo: 1 ####
# 应该这么用才对
session = Capybara::Session.new(:poltergeist)
session.visit("http://demo.aisec.cn/demo/aisec/")
puts session.current_url

exit()
links = session.all(:xpath, "//a")
links[0].click
puts session.current_url
session.evaluate_script('window.history.back(2)')
puts session.current_url
#links[1].click
#puts session.html
##################
