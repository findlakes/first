require 'nmap/program'
require 'nmap/xml'

#scan = Nmap::XML
scan = Nmap::XML.load("")

Nmap::Program.scan do |nmap|
  nmap.syn_scan = true
  nmap.service_scan = true
  #nmap.os_fingerprint = true
  #nmap.xml = 'scan.xml'
  nmap.xml = scan
  nmap.verbose = true

  nmap.ports = [80,443,1080]
  nmap.targets = 'localhost'
end

puts "========================="
puts scan


Nmap::XML.load(scan) do |xml|
  xml.each_host do |host|
    puts "[#{host.ip}]"

    host.each_port do |port|
      puts "  #{port.number}/#{port.protocol}\t#{port.state}\t#{port.service}"
    end
  end
end
