#!/usr/bin/env python

#
# Ref: python-nmap
# https://pypi.python.org/pypi/python-nmap
# http://xael.org/norman/python/python-nmap/
# New Research: libnamp
# https://pypi.python.org/pypi/python-libnmap/0.6.1
# https://libnmap.readthedocs.org/en/latest/process.html
#
import nmap
nm = nmap.PortScanner()
nm.scan('192.168.144.0/28','80')

#print(nm.command_line())
#print(nm.scaninfo())
#print(nm.all_hosts())

 # a more usefull example :
for host in nm.all_hosts():
    #print('----------------------------------------------------')
#    print('Host : %s (%s)' % (host, nm[host].hostname()))
#    print('State : %s' % nm[host].state())

    for proto in nm[host].all_protocols():
#        print('----------')
#        print('Protocol : %s' % proto)

        for port in nm[host][proto].keys():
            if nm[host][proto][port]['state'] == 'open':
                hhost = host
                hname = nm[host][proto][port]['name']
                hstate = nm[host][proto][port]['state']
                hport = port
                print('%s : \tport : %s\tstate : %s\tname : %s' % (hhost, hport, hstate, hname))

#print('----------------------------------------------------')

