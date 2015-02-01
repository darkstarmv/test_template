default['consul']['domain'] = '.consul'

default['consul_template']['config']['consul'] =  '127.0.0.1:8500'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['accept_license_agreement'] = true
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = 7

default[:dnsmasq][:enable_dns] = true
#node.default[:dnsmasq][:enable_dhcp] = true

#node.default[:dnsmasq][:dhcp] = {
#  'enable-tftp' => nil,
#  'interface' => 'eth1'
#}
default['dnsmasq']['dns'] = { 'server' => '/consul/127.0.0.1#8600' }
