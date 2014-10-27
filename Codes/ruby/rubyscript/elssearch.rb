#!/usr/bin/env ruby

require 'json'

ret = `curl -XGET 'http://localhost:19200/logstash-2014.07.09/_search?pretty' -s -d '{
  "query": {
    "filtered": {
      "query": {
        "bool": {
          "should": [
            {
              "query_string": {
                "query": "*"
              }
            }
          ]
        }
      }
    }
  },
  "size": 500
}'
`
#p ret
str = "As of Date,Fiscal Year,Region,Borrower Country,Borrower Country Code,Project ID,Project Name,Procurement Type,Procurement Category,Procurement Method,Product line,WB Contract Number,Major Sector,Contract Description,Contract Signing Date,Supplier,Supplier Country,Supplier Country Code,Total Contract Amount (USD),Borrower Contract Reference Number\n"
my_hash = JSON.parse(ret)
json_array =  my_hash['hits']['hits']
json_array.each do |item|

str += '12/18/2012 12:00:00 AM,2013,Asia,dest ip,CN,P1,PN1,PrT1,PrC1,PrM1,PrL1,0,SQL,MiaoShu,07/17/2012 12:00:00 PM,Address,src ip,'+item['_source']['country']+',$0,0'+"\n"
#p item['_source']['country']

end

puts str
