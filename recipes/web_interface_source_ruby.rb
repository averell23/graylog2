include_recipe 'ruby_from_source'
include_recipe 'graylog2::web_interface'


ruby_bin = "#{node.ruby_from_source.prefix}/ruby/current/bin"
web_home = "#{node.graylog2.basedir}/web"

# Perform bundle install on the newly-installed Graylog2 web interface version
execute "bundle install" do
  command "#{ruby_bin}/bundle install --deployment --path='#{node.graylog2.basedir}#{node.graylog2.bundle_gems_folder}'"
  cwd web_home
  user node.graylog2.web_interface.user
  group node.graylog2.web_interface.group
end

template "/etc/init/graylog_web.conf" do
  source 'graylog_web.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    :web_home => web_home,
    :web_user => node.graylog2.web_interface.user,
    :web_port => node.graylog2.web_interface.port,
    :ruby_path => ruby_bin
  )
end

service "graylog_web" do
  action [:enable, :start]
end