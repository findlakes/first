require 'pp'
require "open-uri"
require 'json'

cluster_info = {}
nodes_info = []
uri = 'http://localhost:19200/_cluster/health'
html_response = nil
open(uri) do |http|
  html_response = http.read
end
#puts html_response
my_hash = JSON.parse(html_response)
cluster_info['cluster_name'] = my_hash['cluster_name']
cluster_info['cluster_status'] = my_hash['status']
cluster_info['number_of_nodes'] = my_hash['number_of_nodes']
cluster_info['number_of_data_nodes'] = my_hash['number_of_data_nodes']
cluster_info['active_primary_shards'] = my_hash['active_primary_shards']
cluster_info['active_shards'] = my_hash['active_shards']
pp cluster_info

uri = 'http://localhost:19200/_nodes/stats/os,fs'
html_response = nil
open(uri) do |http|
  html_response = http.read
end
#puts html_response
i=0
my_hash = JSON.parse(html_response)
  my_hash["nodes"].each do |item|
  node_info = {}
  node_info['node_name'] = item[1]["name"]
  node_info['node_ip'] = item[1]["transport_address"]
  node_info['free_cpu'] = item[1]["os"]["cpu"]["idle"]
  node_info['free_mem'] = item[1]["os"]["mem"]["free_percent"]
  node_info['free_disk'] = item[1]["fs"]["total"]["available_in_bytes"]
#  pp node_info
  nodes_info[i] = node_info
  i=i+1
end

pp nodes_info
