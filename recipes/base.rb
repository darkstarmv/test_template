package 'bind-utils'
include_recipe 'dnsmasq'
#include_recipe 'chef-client'
node.set['consul']['client_address'] = '0.0.0.0'
