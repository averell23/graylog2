include_recipe "nginx"


# Create unicron socket directory
directory "#{node.graylog2.basedir}#{node.graylog2.shared_run_directory}" do
  mode 0755
  owner node.graylog2.web_interface.user
  group node.graylog2.web_interface.group
  recursive true
end

pid_file = "#{node.graylog2.basedir}#{node.graylog2.shared_run_directory}/#{node.graylog2.unicorn.pid}"

template "#{node.graylog2.basedir}/web/config/unicorn.rb" do
  source 'unicorn/unicorn.rb.erb'
  owner node.graylog2.web_interface.user
  group node.graylog2.web_interface.group
  mode '0664'
  variables(
    :listen => { node.graylog2.unicorn.port => node.graylog2.unicorn.options, "'#{node.graylog2.basedir}#{node.graylog2.shared_run_directory}/unicorn.socket'" => node.graylog2.unicorn.socket.options },
    :working_directory => "#{node.graylog2.basedir}/web",
    :bundle_gemfile   =>  "#{node.graylog2.basedir}/web/Gemfile",
    :worker_timeout   =>   node.graylog2.unicorn.worker_timeout,
    :worker_processes =>   node.graylog2.unicorn.worker_processes,
    :stderr_path      =>   "#{node.graylog2.basedir}/web/log/stderr.log",
    :stdout_path      =>   "#{node.graylog2.basedir}/web/log/stdout.log",
    :pid              =>   pid_file
  )
end

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