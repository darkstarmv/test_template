#
# Cookbook Name:: test_template
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'test_template::base'
node.set['consul']['node_name'] =  ("cserver-#{node['test_template']['hostip']}").gsub!('.','-')
#
node.set['consul']['service_mode'] = 'bootstrap'
# need to keep in bootstrap mode for a single server
#node.override['consul']['service_mode'] = 'server'
node.set['consul']['serve_ui'] = true
#######
include_recipe "consul::default"
include_recipe "consul::ui"
