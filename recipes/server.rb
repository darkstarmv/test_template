#
# Cookbook Name:: test_template
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node.set['consul']['service_mode'] = 'server'
node.set['consul']['service_ui'] = true
node.set['consul']['bind_address'] = 'eth1'
node.set['consul']['client_interface'] = 'eth1'

include_recipe "consul::default"
include_recipe "consul::ui"
