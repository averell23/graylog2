include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"
if node.graylog2.apache2.ssl.enabled
  include_recipe "apache2::mod_ssl"
end

template "#{node['apache']['dir']}/sites-available/graylog2" do
  source "graylog2.apache2.erb"
  notifies :reload, "service[apache2]"
end

apache_site "graphite"
