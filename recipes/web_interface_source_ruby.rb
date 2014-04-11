include_recipe 'ruby_from_source'
include_recipe 'graylog2::server'
include_recipe 'graylog2::web_interface'

ruby_bin = "#{node.ruby_from_source.prefix}/ruby/current/bin"
web_home = "#{node.graylog2.basedir}/web"

template "/etc/init/graylog_web.conf" do
  source 'graylog_web.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    :web_home => web_home,
    :web_user => node.graylog2.web_interface.user,
    :web_port => node.graylog2.web_interface.port,
    :ruby_path => ruby_bin,
    :ssl => node.graylog2.web_interface.ssl
  )
end

service "graylog_web" do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
end
