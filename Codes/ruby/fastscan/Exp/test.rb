#
# Module:
# Information Collection.
#
module Collection

	TUPLES = 
	[
		{"file"=>"Apache.fuzz.txt","desc"=>""},
		{"file"=>"IIS.fuzz.txt","desc"=>""},
		{"file"=>"Logins.fuzz.txt","desc"=>""},
		{"file"=>"Passwords.fuzz.txt","desc"=>""},
		{"file"=>"Weblogic.fuzz.txt","desc"=>""},
		{"file"=>"ApacheTomcat.fuzz.txt","desc"=>""},
		{"file"=>"JBoss.fuzz.txt","desc"=>""},
		{"file"=>"Oracle9i.fuzz.txt","desc"=>""},
		{"file"=>"PHP.fuzz.txt","desc"=>""},
		{"file"=>"Websphere.fuzz.txt","desc"=>""},
		{"file"=>"Extensions.Backup.fuzz.txt","desc"=>""},
	]
                    
  def Collection.test
	puts "123"
  end

end

Collection.test

puts Collection::TUPLES.to_s
