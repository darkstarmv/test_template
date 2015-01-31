#
# Cookbook Name:: test_template
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
node.set['consul']['service_mode'] = 'client'
node.set['consul']['bind_address'] = 'eth1'
node.set['consul']['client_interface'] = 'eth1'

include_recipe "haproxy::install_package"

include_recipe "consul::default"
include_recipe "consul-template::default"

consul_service_def 'ta-api-lb' do
  port 80
  tags ['_sip._tcp']
  check(
    interval: '10s',
    script: 'echo ok'
  )
  notifies :reload, 'service[haproxy]'
end

consul_template_config 'haproxy' do
  templates [{
    source: '/etc/haproxy/haproxy.cfg.ctmpl',
    destination: '/etc/haproxy/haproxy.cfg',
    command: 'service haproxy reload'
  }]
  notifies :reload, 'service[consul-template]', :delayed
end

