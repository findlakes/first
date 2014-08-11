#!/usr/bin/env python

from datetime import datetime
from elasticsearch import Elasticsearch

es = Elasticsearch()

# Indices.
#es.indices.create(index='test-index', ignore=400)
#es.indices.delete(index='scan_index')

# Insert
#doc = {
#    'host': '127.0.0.1',
#    'port': '80',
#    'name': 'http',
#    'state': 'up',
#    'timestamp': datetime.now()
#}
#scan_id = 'scan01'
#res = es.index(index="test_index", doc_type=scan_id, body=doc)
#print(res['created'])

# Search
#res = es.search(index="scan_index", body={"query": {"match_all": {}}})
res = es.search(index="scan_index", body={"query": {"match" : {"name":"telnet"}}})
print("Got %d Hits:" % res['hits']['total'])
for hit in res['hits']['hits']:
    print("%(timestamp)s %(host)s: %(port)s" % hit["_source"])


