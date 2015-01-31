#
# Cookbook Name:: test_template
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

#node.set['consul']['service_mode'] = 'bootstrap'
#include_recipe_now 'consul::default'

node.override['consul']['service_mode'] = 'server'
node.set['consul']['serve_ui'] = true

node.set['consul']['bind_interface'] = 'eth1'
node.set['consul']['advertise_interface'] = 'eth1'
#node.set['consul']['client_interface'] = 'eth1'
node.set['consul']['client_address'] = '0.0.0.0'

#node.set['consul']['bind_addr'] = '192.168.33.10'
#node.set['consul']['advertise_addr'] = '192.168.33.10'
#node.set['consul']['client_interface'] = 'eth1'

include_recipe "consul::default"
include_recipe "consul::ui"
