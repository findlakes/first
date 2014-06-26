#!/usr/bin/env ruby
require 'net/http'
require 'thread'

dict1=["HINET-IP","ILMI","Unused","a","a.auth-ns,a01","a02","a1","a2","abc","abhsia","about","ac","academico","acceso","access","accounting","accounts","acessonet","acid","activestat","ad","adam","adkit","admin",
"administracion","administrador","administrator","administrators","admins","ads","adserver","adsl","adslgp","advance","ae","af","affiliate","affiliates","afiliados","ag","agenda","agent","ai","aix","ajax","ak","akamai",
"al","alabama","alaska","albq","albuquerque","alerts","alestra","alpha","alterwind","am","amarillo","amedd","americas","an","anaheim","analyzer","announce","announcements","antivirus","ao","ap","apache","apg","apol",
"apollo","app","app01","app1","apple","application","applications","applwi","apps","appserver","aq","ar","arc","archie","arcsight","argentina","arizona","arkansas","arlington","arpa","ars","as","as400","asia","asianet","asm",
"asterix","at","athena","atlanta","atlas","att","au","auction","austin","austtx","auth","auto","av","available","avantel","aw","ayuda","az","b","b.auth-ns","b01","b02","b1","b2","b2b","b2c","ba","back","backend","backup","baker",
"bakersfield","balance","balancer","baltimore","banking","bayarea","bb","bbdd","bbs","bchsia","bcvloh","bd","bdc","be","bea","beta","bf","bg","bgk","bh","bhm","bi","bigpond","billing","biz","biztalk","bj","black","blackberry",
"bliss","blog","blogs","blue","blueyonder","bm","bn","bna","bnc","bo","bob","bof","bois","boise","bol","bolsa","bootp","border","boston","boulder","boy","bpb","br","brasiltelecom","bravo","brazil","bredband","britian","broadband",
"broadcast","broker","bronze","brown","bs","bsd","bsd0","bsd01","bsd02","bsd1","bsd2","bt","btas","buffalo","bug","buggalo","bugs","bugzilla","build","bulletins","burn","burner","buscador","business","buy","bv","bw","by","bz",
"c","c.auth-ns","ca","cable","cache","cae","cafe","calendar","california","call","calvin","canada","canal","canon","careers","catalog","cc","ccgg","cd","cdburner","cdn","cert","certificates","certify","certserv","certsrv",
"cf","cg","cgi","ch","channel","channels","charlie","charlotte","chat","chats","chatserver","chcgil","check","checkpoint","chi","chicago","chs","ci","cicril","cidr","cims","cinci","cincinnati","cisco","citrix","ck","cl",
"class","classes","classifieds","classroom","cleveland","clicktrack","client","clientes","clients","clsp","clt","clta","club","clubs","cluster","clusters","cm","cmail","cms","cn","co","cocoa","code","codetel","coldfusion",
"colombus","colorado","columbus","com","commerce","commerceserver","communigate","community","compaq","compras","compute-1","con","concentrator","conf","conference","conferencing","confidential","connect","connecticut",
"consola","console","consult","consultant","consultants","consulting","consumer","contact","content","contracts","core","core0","core01","cork","corp","corp-eur","corpmail","corporate","correo","correoweb","cortafuegos",
"counterstrike","courses","cpe","cr","cricket","crm","crs","cs","cso","css","ct","cu","cust","cust-adsl","customer","customers","cv","cvs","cx","cy","cz","d","d4","da","dallas","data","database","database01",
"database02","database1","database2","databases","datastore","datos","david","db","db0","db01","db02","db1","db2","dc","de","dealers","dec","ded","def","default","defiant","delaware","dell","delta","delta1","demo",
"demon","demonstration","demos","denver","deploy","depot","des","desarrollo","descargas","design","designer","detroit","dev","dev0","dev01","dev1","devel","develop","developer","developers","development","device",
"devserver","devsql","dhcp","dhcp-bl","dhcp-in","dhcp4","dial","dialuol","dialup","digital","digitaltv","dilbert","dion","dip","dip0","dir","direct","directory","disc","discovery","discuss","discussion","discussions",
"disk","disney","distributer","distributers","dj","dk","dm","dmail","dmz","dnews","dns","dns-2","dns0","dns1","dns2","dns3","do","docs","documentacion","documentos","domain","domains","dominio","domino","dominoweb",
"domolink","doom","download","downloads","downtown","dragon","drupal","dsl","dsl-w","dt","dti","dublin","dyn","dynamic","dynamicIP","dynip","dz","e","e-com","e-commerce","e0","eagle","earth","east","ec","echo","ecom",
"ecommerce","ed","edi","edu","education","edward","ee","eg","eh","ejemplo","elpaso","email","embratel","emhril","employees","empresa","empresas","en","enable","eng","eng01","eng1","engine","engineer","engineering",
"enterprise","eonet","epm","epsilon","er","erp","es","esd","esm","espanol","est","estadisticas","esx","et","eta","etb","eu","eur","europe","events","example","exchange","exec","extern","external","extranet","f","f5"]

dict2=["falcon","farm","faststats","fax","fbx","feedback","feeds","fi","fibertel","field","file","files","fileserv","fileserver","filestore","filter","find","finger","fios","firewall","fix","fixes","fj","fk","fl","flash",
"florida","flow","fm","fo","foobar","formacion","foro","foros","fortworth","forum","forums","foto","fotos","foundry","fox","foxtrot","fr","france","frank","fred","freebsd","freebsd0","freebsd01","freebsd02","freebsd1",
"freebsd2","freeware","fresno","frokca","front","frontdesk","fs","fsp","ftas","ftd","ftp","ftp-","ftp0","ftp2","ftp_","ftpserver","fw","fw-1","fw1","fwd","fwsm","fwsm0","fwsm01","fwsm1","g","ga","galeria",
"galerias","galleries","gallery","galway","games","gamma","gandalf","gate","gatekeeper","gateway","gauss","gd","ge","gemini","general","genericrev","george","georgia","germany","gf","gg","gh","gi","giga","gl","glendale",
"global","gm","gmail","gn","go","gold","goldmine","golf","gopher","gordon","gp","gprs","gq","gr","green","group","groups","groupwise","gs","gsp","gsx","gt","gtcust","gu","guest","gvt","gw","gw1","gy","gye","h","hal",
"halflife","hawaii","hello","help","helpdesk","helponline","henry","hermes","hfc","hi","hidden","hidden-host","highway","hk","hkcable","hlrn","hm","hn","hobbes","hollywood","home","homebase","homer","homerun","honeypot",
"honolulu","host","host1","host3","host4","host5","hotel","hotjobs","houstin","houston","howto","hp","hpov","hr","hrlntx","hsia","hstntx","hsv","ht","http","https","hu","hub","humanresources","i","ia","ias","ibm","ibmdb",
"id","ida","idaho","ids","ie","iern","ig","iis","il","illinois","im","images","imail","imap","imap4","img","img0","img01","img02","impsat","in","in-addr","inbound","inc","include","incoming","india","indiana",
"indianapolis","inet","info","informix","infoweb","inside","install","int","intelignet","intern","internal","internalhost","international","internet","internode","intl","intranet","invalid","investor",
"investors","io","iota","iowa","ip","ip215","ipcom","iplanet","iplsin","ipltin","ipmonitor","iprimus","ipsec","ipsec-gw","ipt","ipv4","iq","ir","irc","ircd","ircserver","ireland","iris","irvine","irving",
"irvnca","is","isa","isaserv","isaserver","ism","isp","israel","isync","it","italy","ix","j","jan","japan","java","jax","je","jedi","jm","jo","jobs","john","jp","jrun","jsc","juegos","juliet","juliette",
"juniper","k","k12","kansas","kansascity","kappa","kb","kbtelecom","ke","kentucky","kerberos","keynote","kg","kh","ki","kilo","king","klmzmi","km","kn","knowledgebase","knoxville","koe","korea","kp","kr",
"ks","ksc2mo","kw","ky","kz","l","la","lab","laboratory","labs","lambda","lan","laptop","laserjet","lasvegas","launch","lb","lc","ldap","legal","leo","lewis","lft","li","lib","library","lima","lincoln","link",
"linux","linux0","linux01","linux02","linux1","linux2","lista","lists","listserv","listserver","live","livnmi","lk","ll","lnk","load","loadbalancer","local","localhost","log","log0","log01","log02","log1","log2",
"logfile","logfiles","logger","logging","loghost","login","logs","london","longbeach","losangeles","lotus","louisiana","lr","ls","lsan03","lt","ltrkar","lu","luke","lv","lw","ly","lyris","m","ma","maa","mac","mac1",
"mac10","mac11","mac2","mac3","mac4","mac5","mach","macintosh","madrid","mail","mail2","mailer","mailgate","mailhost","mailing","maillist","maillists","mailroom","mailserv","mailsite","mailsrv","main","maine","maint",
"mall","manage","management","manager","manufacturing","map","mapas","maps","marketing","marketplace","mars","marvin","mary","maryland","massachusetts","master","max","maxonline","mc","mci","mco","md","mdaemon","me","med",
"media","megaegg","megared","mem","member","members","memphis","mercury","merlin","mesh","messages","messenger","mg","mgmt","mh","mi","mia","miamfl","miami","michigan","mickey","mid","midwest","mike","milwaukee","milwwi"]

dict3=["minneapolis","minnesota","mirror","mis","mississippi","missouri","mk","ml","mm","mn","mngt","mo","mob","mobile","mobileonline","mom","monitor","monitoring","montana","moon","moscow","movies","mozart","mp","mp3","mpeg",
"mpg","mpls","mq","mr","mrt","mrtg","ms","ms-exchange","ms-sql","msexchange","mssnks","mssql","mssql0","mssql01","mssql1","msy","mt","mta","mtnl","mtu","mu","multimedia","music","mv","mw","mweb","mx","my","mysql",
"mysql0","mysql01","mysql1","mz","n","na","nam","name","names","nameserv","nameserver","nas","nashville","nat","nb","nc","nd","nds","ne","nebraska","neo","neptune","net","netapp","netdata","netgear","netmeeting",
"netscaler","netscreen","netstats","netvision","network","nevada","new","newhampshire","newjersey","newmexico","neworleans","news","newsfeed","newsfeeds","newsgroups","newton","newyork","newzealand","nf","ng","nh",
"ni","nigeria","nj","nl","nm","nms","nntp","no","no-dns","no-dns-yet","node","nokia","nombres","nora","north","northcarolina","northdakota","northeast","northwest","not-set-yet","nothing","noticias","novell",
"november","np","nr","ns","ns-","ns0","ns01","ns02","ns1","ns2","ns3","ns4","ns5","ns_","nswc","nt","nt4","nt40","ntmail","ntp","ntserver","nu","null","nv","nw","ny","nycap","nz","o","oakland","oc","ocean","ocn",
"odin","odn","office","offices","oh","ohio","oilfield","ok","okc","okcyok","oklahoma","oklahomacity","old","om","omah","omaha","omega","omicron","online","ontario","open","openbsd","openview","operations","ops","ops0",
"ops01","ops02","ops1","ops2","opsware","optusnet","or","oracle","orange","order","orders","oregon","orion","orlando","oscar","out","outbound","outgoing","outlook","outside","ov","owa","owa01","owa02","owa1","owa2","owb",
"ows","oxnard","p","pa","pac","page","pager","pages","paginas","papa","paris","parners","partner","partners","patch","patches","paul","payroll","pbx","pc","pc01","pc1","pc10","pc101","pc11","pc12","pc13","pc14","pc15",
"pc16","pc17","pc18","pc19","pc2","pc20","pc21","pc22","pc23","pc24","pc25","pc26","pc27","pc28","pc29","pc3","pc30","pc31","pc32","pc33","pc34","pc35","pc36","pc37","pc38","pc39","pc4","pc40","pc41","pc42","pc43","pc44",
"pc45","pc46","pc47","pc48","pc49","pc5","pc50","pc51","pc52","pc53","pc54","pc55","pc56","pc57","pc58","pc59","pc6","pc60","pc7","pc8","pc9","pcmail","pcs","pda","pdc","pe","pegasus","pennsylvania","peoplesoft","personal",
"pf","pg","pgp","ph","phi","philadelphia","phnx","phoenix","phoeniz","phone","phones","photos","pi","pics","pictures","pink","pipex-gw","pittsburgh","pix","pk","pki","pl","plala","plano","platinum","pltn13","pluto","pm",
"pm1","pn","po","pol","policy","polls","pool","pools","pop","pop3","portal","portals","portfolio","portland","post","postales","postoffice","ppp","ppp1","ppp10","ppp11","ppp12","ppp13","ppp14","ppp15","ppp16","ppp17",
"ppp18","ppp19","ppp2","ppp20","ppp21","ppp3","ppp4","ppp5","ppp6","ppp7","ppp8","ppp9","pppoe","pptp","pr","prensa","press","prima","printer","printserv","printserver","priv","privacy","private","problemtracker",
"prod-empresarial","prod-infinitum","prodigy","products","profiles","project","projects","promo","proxy","prueba","pruebas","ps","psi","pss","pt","ptld","ptr","pub","public","pubs","purple","pw","py","q","qa","qmail",
"qotd","quake","quebec","queen","quotes","r","r01","r02","r1","r2","ra","radio","radius","ramstein","range217-42","range217-43","range217-44","range86-128","range86-129","range86-130","range86-131","range86-132",
"range86-133","range86-134","range86-135","range86-136","range86-137","range86-138","range86-139","range86-140","range86-141","range86-142","range86-143","range86-144","range86-145","range86-146","range86-147",
"range86-148","range86-149","range86-150","range86-151","range86-152","range86-153","range86-154","range86-155","range86-156","range86-157","range86-158","range86-159","range86-160","range86-161","range86-162","range86-163",
"range86-164","range86-165","range86-166","range86-167","range86-168","range86-169","range86-170","range86-171","range86-172","range86-173","range86-174","range86-176","range86-177","range86-178","range86-179","range86-180"]

dict4=["range86-181","range86-182","range86-183","range86-184","range86-185","range86-186","range86-187","range86-188","range86-189","rapidsite","raptor","ras","rc","rcs","rcsntx","rd","rdns","re","read","realserver",
"recruiting","red","redhat","ref","reference","reg","register","registro","registry","regs","relay","rem","remote","remstats","reports","res","research","reseller","reserved","resnet","resumenes","retail","rev",
"reverse","rho","rhodeisland","ri","ris","rmi","ro","robert","rochester","romeo","root","rose","route","router","router1","rs","rss","rtc5","rtelnet","rtr","rtr01","rtr1","ru","rune","rw","rwhois","s","s1","s2","sa",
"sac","sacramento","sadmin","safe","sales","saltlake","sam","san","sanantonio","sandiego","sanfrancisco","sanjose","saskatchewan","sasknet","saturn","savecom","sb","sbs","sc","scanner","schedules","scotland",
"scotty","scrm01","sd","sdf","sdsl","se","sea","search","seattle","sec","secret","secure","secured","securid","security","seed","segment-119-226","segment-119-227","segment-124-30","segment-124-7","sendmail",
"seri","serv","serv2","server","server1","servers","service","services","servicio","servidor","setup","sfldmi","sg","sh","shared","sharepoint","shareware","shipping","shop","shoppers","shopping","shv","si",
"siebel","sierra","sigma","signin","signup","silver","sim","sirius","site","siw","sj","sk","skywalker","sl","slackware","slkc","slmail","sm","smc","sms","smtp","smtphost","sn","snantx","sndg02","sndgca",
"snfc21","sniffer","snmp","snmpd","snoopy","snort","sntcca","so","so-net","socal","software","sol","solaris","solutions","soporte","source","sourcecode","sourcesafe","south","southcarolina","southdakota","southeast",
"southwest","spain","spam","spawar","speed","speedy","spider","spiderman","spkn","splunk","spock","spokane","springfield","sprint","sqa","sql","sql0","sql01","sql1","sql7","sqlserver","squid","sr","ss","ssd","ssh",
"ssl","ssl0","ssl01","ssl1","st","sta","staff","stage","staging","start","stat","static","static-ip-92-71","staticIP","statistics","stats","stl2mo","stlouis","stlsmo","stock","storage","store","storefront","streaming",
"stronghold","strongmail","student","studio","submit","subversion","sun","sun0","sun01","sun02","sun1","sun2","superman","supplier","suppliers","support","sv","sw","sw0","sw01","sw1","sweden","switch","switzerland","sy",
"sybase","sydney","sysadmin","sysback","syslog","syslogs","system","sz","t","t-com","tachikawa","tacoma","taiwan","talk","tampa","tango","tau","tbcn","tc","tcl","tcso","td","tdatabrasil","team","tech","technology",
"techsupport","telecom","telefonia","telemar","telephone","telephony","telesp","telkomadsl","telnet","temp","tennessee","terminal","terminalserver","termserv","test","test2k","testbed","testing","testlab","testlinux",
"testserver","testsite","testsql","testxp","texas","tf","tfn","tftp","tg","th","thailand","theta","thor","tienda","tiger","time","tinp","titan","tivoli","tj","tk","tm","tn","to","tokyo","toledo","tom","tool","tools",
"toplayer","tor","toronto","tour","tp","tpgi","tr","tracker","train","training","transfers","trinidad","trinity","ts","ts1","ts31","tsinghua","tt","tucson","tukrga","tukw","tulsa","tunnel","tv","tw","twcny","tx","txr",
"tz","u","ua","ucom","uddi","ug","uio","uk","um","unassigned","undefined","undefinedhost","uniform","uninet","union","unitedkingdom","unitedstates","unix","unixware","unk","unknown","unspec170108","unspec207128",
"unspec207129","unspec207130","unspec207131","unused-space","uol","upc-a","upc-h","upc-i","upc-j","update","updates","upload","ups","upsilon","uranus","urchin","us","usa","usenet","user","users","ut","utah","utilities",
"uunet","uy","uz","v","v4","va","vader","validip","van","vantive","vault","vc","ve","vega","vegas","veloxzone","vend","vendors","venus","vermont","vg","vi","victor","video","videos","vie","viking","violet","vip","virginia",
"vista","vm","vmserver","vmware","vn","vnc","vodacom","voice","voicemail","voip","voyager","vpn","vpn0","vpn01","vpn02","vpn1","vpn2","vsnl","vt","vu","w","w1","w2","w3","wa","wais","wakwak","wallet","wam","wan","wap"]

dict5=["war","warehouse","washington","water","wc3","web","webaccess","webadmin","webalizer","webboard","webcache","webcam","webcast","webdev","webdocs","webfarm","webhelp","weblib","weblogic","webmail","webmaster","webproxy",
"webring","webs","webserv","webserver","webservices","website","websites","websphere","websrv","websrvr","webstats","webstore","websvr","webtrends","welcome","west","westnet","westvirginia","wf","whiskey","white","whois",
"wi","wichita","wiki","wililiam","wimax-client","win","win01","win02","win1","win2","win2000","win2003","win2k","win2k3","windows","windows01","windows02","windows1","windows2","windows2000","windows2003","windowsxp",
"wingate","winnt","winproxy","wins","winserve","winxp","wire","wireless","wisconsin","wlan","wlfrct","woh","wood","wordpress","work","world","wotnoh","write","ws","ws1","ws10","ws11","ws12","ws13","ws2","ws3","ws4",
"ws5","ws6","ws7","ws8","ws9","wusage","wv","ww","www","www-","www-01","www-02","www-1","www-2","www-int","www0","www01","www02","www1","www2","www3","www_","wwwchat","wwwdev","wwwmail","wy","wyoming","x","x-ray",
"xdsl","xi","xlogan","xmail","xml","xp","xr","y","y12","yankee","ye","yellow","yokohama","young","yournet","yt","yu","z","z-log","za","zaq","zebra","zera","zeus","zlog","zm","zulu","zw","zz"]


require "./mytask.rb"
mytask = Mytask.new("task.db")

db_path = '/root/Project/rails/boot_test/db/development.sqlite3'
db = SQLite3::Database.new db_path

def getinfo(uris)
  begin
	uri = URI(uris)
	res = Net::HTTP.get_response(uri)
	[res.code, res.msg]
  rescue
	#puts "Request failed : #{uris}  #{$!}"
  end
end

def fetch(glossary, task, db)
  glossary.each do |priname|
	var1 = 'http://'+priname+'.'+task[1]+'/'
	info = getinfo(var1)
        db.execute "insert into sublists values (null, '#{var1}', '#{info.join(' ')}', #{task[0]}, datetime(), datetime());" if info != nil
	puts var1 + ' '  + info.join(' ') if info != nil
  end
end

if !ARGV[0].nil?
targetid=ARGV[0].to_s 
#p targetid
target = mytask.get_task(targetid)
target = target[0]
#p var[0]

=begin
dict0 = ["www","mail"]
thr0 =  Thread.new { 
 puts "thr0 start."
 fetch(dict0, var[0], db) 
}
thr0.join
=end

thr1 = Thread.new { puts "thr1 start."; fetch(dict1, target, db) }
thr2 = Thread.new { puts "thr2 start."; fetch(dict2, target, db) }
thr3 = Thread.new { puts "thr3 start."; fetch(dict3, target, db) }
thr4 = Thread.new { puts "thr4 start."; fetch(dict4, target, db) }
thr5 = Thread.new { puts "thr5 start."; fetch(dict5, target, db) }
thr1.join
thr2.join
thr3.join
thr4.join
thr5.join

puts "Threads End..."

end

