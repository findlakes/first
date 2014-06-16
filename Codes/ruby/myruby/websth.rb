# encoding: utf-8
require 'net/http'
# Get the links from http://websth.com/tech/

techs = ['Atlassian%20Jira','AWStats','Blogger','Bugzilla','cPanel','DeDeCMS','Discuz!','DokuWiki','Drupal','EmpireCMS','Invision%20Power%20Board','Joomla!','LimeSurvey','MediaWiki','Movable%20Type','NexusPHP','PHP-Nuke','phpBB','PHPCMS','PHPMyAdmin','phpSQLiteCMS','PHPWind','Pligg','Pwiki','Redmine','Struts1','Struts2','vBulletin','WordPress','Z-Blog']

begin

techs.each do |tech|
  puts "=== Tech:#{tech} ==="
  (1..2).each do |page|
    puts "+++ Page:#{page} +++"
    uri = URI("http://websth.com/tech/#{tech}/#{page}")
    res = Net::HTTP.get(uri) #puts res
    items = res.scan(/<td><a href="http:\/\/.*:\d+\/" target="_blank">(.*)<\/a><\/td>/)
    break if items.size == 0
    items.each {|item| puts item}
  end
end

rescue
  puts "Request failed. #{$!}"
end
