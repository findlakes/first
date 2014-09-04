#
# Structure
#

$dataset = {

	"Policy" => {"WEB_INFO" => true},

	"SERVER_INFO" => {
		"enable"=> true,
		"level" => 5,
		"desc"=>"Detection Sever",
		"list"=>[]
	},

	"PORT_INFO" => {
		"enable"=> true,
		"level" => 5,
		"desc"=>"Detection Port",
		"ports" => [21,22,23,25,80,443,3306,3389,1433,1521,8080],
		"list"=>[]
	},

	"WEB_INFO" => {
		"enable"=> true,
		"level" => 5,
		"desc"=>"Detection WEB Server",
		"array" => [
		{"file"=>"Tomcat.fuzz.txt", "desc"=>"Detection Tomcat", "list"=>[]},
		{"file"=>"Websphere.fuzz.txt", "desc"=>"Detection Websphere", "list"=>[]},
		{"file"=>"Weblogic.fuzz.txt", "desc"=>"Detection Weblogic", "list"=>[]},
		{"file"=>"Apache.fuzz.txt", "desc"=>"Detection Apache", "list"=>[]},
		{"file"=>"JBoss.fuzz.txt", "desc"=>"Detection JBoss", "list"=>[]},
		{"file"=>"IIS.fuzz.txt", "desc"=>"Detection IIS", "list"=>[]},
		]
	},

	"BACK_INFO" => {
		"enable"=> true,
		"level" => 5,
		"desc"=>"Detection Backup File",
		"array" => [
		{"file"=>"Backup.fuzz.txt", "desc"=>"Detection Backup", "list"=>[]},
		]
	},

	"LOGIN_INFO" => {
		"enable"=> true,
		"level" => 5,
		"desc"=>"Detection Login Page",
		"array" => [
		{"file"=>"Logins.fuzz.txt", "desc"=>"Detection Logins", "list"=>[]},
		{"file"=>"Passwords.fuzz.txt", "desc"=>"Detection Passwords", "list"=>[]},
		]
	},

	"DOOR_INFO" => {
		"enable"=> true,
		"level" => 5,
		"desc"=>"Detection BackDoor",
		"array" => [
		{"file"=>"Backdoor.fuzz.txt", "desc"=>"Detection BackDoor", "list"=>[]},
		]
	},

}
