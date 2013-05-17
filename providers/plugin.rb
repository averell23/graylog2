action :install do

  execute "install plugin #{new_resource.plugin_name}" do
    cwd "#{node.graylog2.basedir}/server"
    command "java -jar graylog2-server.jar --install-plugin #{new_resource.plugin_name}"
  end

end
