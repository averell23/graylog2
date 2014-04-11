#
# Cookbook Name:: graylog2
# Recipe:: web_interface
#
# Copyright 2010, Medidata Solutions Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ruby_bin = "#{node.ruby_from_source.prefix}/ruby/current/bin"

# Create the release directory
directory "#{node.graylog2.basedir}/rel" do
  mode 0755
  recursive true
end

# Create bundle gems directory
directory "#{node.graylog2.basedir}#{node.graylog2.bundle_gems_folder}" do
  mode 0755
  owner node.graylog2.web_interface.user
  group node.graylog2.web_interface.user
  recursive true
end

# Download the desired version of Graylog2 web interface from GitHub
remote_file "download_web_interface" do
  path "#{node.graylog2.basedir}/rel/graylog2-web-interface-#{node.graylog2.web_interface.version}.tar.gz"
  source "https://github.com/Graylog2/graylog2-web-interface/releases/download/#{node.graylog2.web_interface.version}/graylog2-web-interface-#{node.graylog2.web_interface.version}.tgz"
  action :create_if_missing
end

# Unpack the desired version of Graylog2 web interface
execute "tar zxf graylog2-web-interface-#{node.graylog2.web_interface.version}.tar.gz" do
  cwd "#{node.graylog2.basedir}/rel"
  creates "#{node.graylog2.basedir}/rel/graylog2-web-interface-#{node.graylog2.web_interface.version}/build_date"
  action :nothing
  subscribes :run, resources(:remote_file => "download_web_interface"), :immediately
end

# Link to the desired Graylog2 web interface version
link "#{node.graylog2.basedir}/web" do
  to "#{node.graylog2.basedir}/rel/graylog2-web-interface-#{node.graylog2.web_interface.version}"
end

# Initialize Secrets
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['graylog2']['web_interface_secret'] = secure_password

# Create web interface config
template "#{node.graylog2.basedir}/web/conf/graylog2-web-interface.conf" do
  mode 0644
end

template "/etc/init/graylog_web.conf" do
  source 'graylog_web.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

service "graylog_web" do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
end
