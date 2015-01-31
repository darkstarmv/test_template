
group 'tomcat'
user 'tomcat' do
  group 'tomcat'
end

remote_file "#{Chef::Config[:file_cache_path]}/apache-tomcat-7.0.47.tar.gz" do
  source "http://archive.us.apache.org/dist/tomcat/tomcat-7/v7.0.47/bin/apache-tomcat-7.0.47.tar.gz"
  notifies :run, "execute[extract-apache-tomcat]", :immediately
end
execute "extract-apache-tomcat" do
  cwd "/opt"
  command "tar -xvf #{Chef::Config[:file_cache_path]}/apache-tomcat-7.0.47.tar.gz --transform 's/apache-tomcat-7.0.47/tomcat7/'"
  creates "/opt/tomcat7/bin"
  action :nothing
  notifies :run, "execute[tomcat_permissions]", :immediately
end

execute "tomcat_permissions" do
  cwd "/opt"
  command "chown -R tomcat:tomcat tomcat7"
  action :nothing
  notifies :restart, "service[tomcat]", :delayed
end

include_recipe "runit"


runit_service 'tomcat' do
  template_name 'tomcat'
  options(:user => 'tomcat')
  default_logger true
  action :enable
end
