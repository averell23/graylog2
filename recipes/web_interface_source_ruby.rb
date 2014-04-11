include_recipe 'ruby_from_source'
include_recipe 'graylog2::server'
include_recipe 'graylog2::web_interface'

ruby_bin = "#{node.ruby_from_source.prefix}/ruby/current/bin"
web_home = "#{node.graylog2.basedir}/web"

