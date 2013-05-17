action :install do

  execute "install plugin #{new_resource.name}" do
    cwd "#{node.graylog2.basedir}/server"
    command "java -jar graylog2-server.jar --install-plugin #{new_resource.name} --plugin-version #{new_resource.version}"
  end

end
