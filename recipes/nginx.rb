include_recipe "nginx"

# Create unicorn upstream
template "#{node.nginx.dir}/conf.d/unicorn_upstream.conf" do
  source "nginx/rails_unicorn_upstream.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :use_socket => node.betterplace.nginx.upstream.use_socket,
    :unicorn_socket => "#{node.graylog2.basedir}/shared/run/#{node.graylog2.unicorn.socket.file}",
    :unicorn_port => node.graylog2.unicorn.port,
    :ippool => node.graylog2.nginx.app.ippool
    })
end

domain_name = "graylog2.betterplace.org"
domain_aliases = ""
# Create unicorn proxy virtual for nginx
template "#{node.nginx.dir}/sites-available/#{domain_name}" do
  source "nginx/unicorn_proxy.erb"
  owner "root"
  group "root"
  mode 0644
  variables({
    :rails_unicorn_upstream => "#{node.nginx.dir}/global/unicorn_upstream",
    :server_name => domain_name,
    :server_aliases => domain_aliases,
    :document_root => "#{node.graylog2.basedir}/web/public",
    :error_500_file => "#{node.graylog2.basedir}/web/public/500.html",
    :error_400_file => "#{node.graylog2.basedir}/web/public/400.html",
    :error_log_file => "#{node.graylog2.basedir}/web/log/#{domain_name}.error.log",
    :access_log_file => "#{node.graylog2.basedir}/web/log/#{domain_name}.access.log",
    :secure => false
    })
end

nginx_site domain_name