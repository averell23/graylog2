# Create unicorn socket directory
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

# Stop Unicorn if exists and wait for it, then restart unicorn
if File.exists?(pid_file)
  pid = File.read(pid_file).to_i
  execute  "Stop Unicorn and wait for it" do
    cwd "#{node.graylog2.basedir}/web"
    command "kill #{pid}"
    action :run
    user node.graylog2.web_interface.user
    group node.graylog2.web_interface.group
    timeout 30
    returns [0,1]
  end
end