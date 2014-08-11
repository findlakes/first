#!/usr/bin/env python

from datetime import datetime
from elasticsearch import Elasticsearch
import thread
import time

def do_scan():
    print(123)
    #print("%(timestamp)s %(host)s: %(port)s" % hit["_source"])
    `/bin/ls /`
    time.sleep(3)

es = Elasticsearch()

# Search
res = es.search(index="scan_index", body={"query": {"match" : {"name":"telnet"}}})
print("Got %d Hits:" % res['hits']['total'])
for hit in res['hits']['hits']:
    thread.start_new(do_scan, ())


