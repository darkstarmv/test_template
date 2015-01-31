#
# Cookbook Name:: test_template
# Recipe:: tomcat
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
node.set['consul']['service_mode'] = 'client'
node.set['consul']['bind_address'] = 'eth1'
node.set['consul']['client_interface'] = 'eth1'

include_recipe "tomcat"

include_recipe "consul::default"
include_recipe "consul-template::default"

consul_service_def 'ta-tomcat-api' do
  port 8080
  tags ['_sip._udp']
  check(
    interval: '10s',
    script: 'curl localhost:8080 >/dev/null 2>&1'
  )
  notifies :reload, 'service[consul]'
end

#consul_service_def 'ta-api-tomcat'
#  port 8080
#  tags ['_sip._udp']
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

