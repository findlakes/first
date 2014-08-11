#!/usr/bin/env python

import nmap
from datetime import datetime
from elasticsearch import Elasticsearch

es = Elasticsearch()
nm = nmap.PortScanner()
nm.scan('59.151.50-60.1-254','21,22,23,25,80,81,110,135,139,389,443,445,873,1433,1434,1521,2433,3306,3307,3389,5800,5900,8080,22222,22022,27017,28017')
scan_id = 'scan02'
scan_index = 'scan_index'

for host in nm.all_hosts():
    for proto in nm[host].all_protocols():
        for port in nm[host][proto].keys():
            if nm[host][proto][port]['state'] == 'open':
                hhost = host
                hname = nm[host][proto][port]['name']
                hstate = nm[host][proto][port]['state']
                hport = port
                doc = { 'host': hhost, 'port': hport, 'name': hname, 
                    'state': hstate, 'timestamp': datetime.now() }
                res = es.index(index=scan_index, doc_type=scan_id, body=doc)
                print(res['created'])
                print('%s : \tport : %s\tstate : %s\tname : %s' % (hhost, hport, hstate, hname))

