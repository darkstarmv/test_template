package 'bind-utils'
include_recipe 'dnsmasq'
#include_recipe 'chef-client'
my_ipaddress = "#{node['test_template']['hostip']}"

node.set['consul']['advertise_interface'] = 'eth1'
node.set['consul']['client_address'] = '0.0.0.0'
node.set['consul']['bind_addr'] = node['test_template']['hostip']
node.set['consul']['advertise_addr'] = node['test_template']['hostip']
