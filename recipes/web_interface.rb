#
# Cookbook Name:: rails_install
# Recipe:: default
#
# Copyright 2012, Daniel Hahn
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# include_recipe 'mysql'
#include_recipe "ruby_from_source"
# include_recipe 'build-essential'

include_recipe "passenger_apache2::mod_rails"

# Include some useful packages
package "postfix"
package 'telnet'

# mysql_database node.rails_install.app_name do
#   connection({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
#   action :create
# end
#
# mysql_database_user 'rails' do
#   connection({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
#   password node.rails_install.db_pass
#   database_name node.rails_install.app_name
#   host '%'
#   privileges [:all]
#   action :grant
# end

# %w(database uploads).each do |shared_dir|
#   directory "/var/apps/#{node.rails_install.app_name}/shared/#{shared_dir}" do
#     recursive true
#     owner node.apache.user
#     group node.apache.group
#     mode 0770
#   end
# end


app_path = "/var/apps/graylog2-web-interface"

application "graylog2-web-interface" do
  action :force_deploy
  path app_path
  owner node.apache.user
  group node.apache.group

  repository "git://github.com/Graylog2/graylog2-web-interface.git"
  revision node.graylog2.web_interface.version
  create_dirs_before_symlink ['public', 'config']
  # symlink_before_migrate "database" => "database"
  symlinks "mongoid.yml" => "config/mongoid.yml", "general.yml" => "config/general.yml"

  migrate false

  rails do
    # bundle_command '/opt/local/bin/bundle'
    bundler true
    bundler_deployment false
    # database(
    #   :adapter => 'sqlite3',
    #   :database => 'database/production.sqlite3',
    #   :pool => 5,
    #   :timeout => 5000
    # )
  end

  before_symlink do
    # Create mongoid.yml
    template "#{app_path}/shared/mongoid.yml" do
      owner node.apache.user
      group node.apache.group
      mode 0644
    end

    # Create general.yml
    template "#{app_path}/shared/general.yml" do
      owner node.apache.user
      group node.apache.group
      mode 0644
    end
  end

end

web_app "graylog2-web-interface" do
  docroot "#{app_path}/current/public"
  cookbook "passenger_apache2"
  server_name "graylog"
  server_aliases [ ]
  rails_env "production"
end

# Stream message rake tasks
cron "Graylog2 send stream alarms" do
  minute node[:graylog2][:stream_alarms_cron_minute]
  action node[:graylog2][:send_stream_alarms] ? :create : :delete
  command "cd #{node[:graylog2][:basedir]}/web && RAILS_ENV=production bundle exec rake streamalarms:send"
end

cron "Graylog2 send stream subscriptions" do
  minute node[:graylog2][:stream_subscriptions_cron_minute]
  action node[:graylog2][:send_stream_subscriptions] ? :create : :delete
  command "cd #{node[:graylog2][:basedir]}/web && RAILS_ENV=production bundle exec rake subscriptions:send"
end