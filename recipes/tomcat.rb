#
# Cookbook Name:: test_template
# Recipe:: tomcat
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'test_template::base'

node.set['consul']['service_mode'] = 'client'
node.set['consul']['node_name'] =  ("api-#{node['test_template']['hostip']}").gsub!('.','-')

include_recipe "test_template::_tomcat"


include_recipe "consul::default"
include_recipe "consul-template::default"

consul_service_def 'ta-api' do
  port 8080
  tags [ 'primary' ]
  check(
    interval: '10s',
    script: 'curl localhost:8080 >/dev/null 2>&1'
  )
  notifies :reload, 'service[consul]'
end

#consul_service_def 'ta-api-tomcat'
#  port 8080
#  tags ['_sip._tcp']
#:wend
#  check(
#    interval: '10s',
#    script: 'curl localhost:8080 >/dev/null 2>&1'
#  )
#  notifies :reload, 'service[tomcat]'
#end

#consul_template_config 'war-deployer' do
#  templates [{
#    source: '/tmp/myapp.war',
#    destination: '/tmp/destinationp',
#    command: 'service tomcat restart'
#  }]
#  notifies :reload, 'service[consul-template]', :delayed
#end

