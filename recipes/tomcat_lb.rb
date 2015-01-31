#
# Cookbook Name:: test_template
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
node.set['consul']['service_mode'] = 'client'
node.set['consul']['bind_addr'] = '192.168.33.20'
node.set['consul']['client_address'] = '192.168.33.20'

include_recipe "consul::default"
include_recipe "consul-template::default"
include_recipe "haproxy::install_package"
service "haproxy" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
template "/etc/haproxy/set_haproxy_maxconn.sh" do
  source 'set_haproxy_maxconn.sh'
  mode '0700'
  owner 'root'
  group 'root'
  variables( :hamaxconn => 40000 )
  
end
execute '/etc/haproxy/set_haproxy_maxconn.sh' do
#  not_if 'bundle check' # This is not run inside /myapp
end

cookbook_file 'haproxy.cfg.ctmpl' do
  path '/etc/haproxy/haproxy.cfg.ctmpl'
  action :create_if_missing
end

consul_template_config 'haproxy' do
  templates [{
    source: '/etc/haproxy/haproxy.cfg.ctmpl',
    destination: '/etc/haproxy/haproxy.cfg',
    command: 'service haproxy reload'
  }]
  notifies :reload, 'service[consul-template]', :delayed
end


consul_service_def 'ta-api-lb' do
  port 80
  tags ['_sip._tcp']
  check(
    interval: '10s',
    script: 'echo ok'
  )
  notifies :reload, 'service[haproxy]'
end
