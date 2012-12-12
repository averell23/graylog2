maintainer        "Medidata Solutions Inc."
maintainer_email  "cloudteam@mdsol.com"
license           "Apache 2.0"
description       "Installs and configures Graylog2"
version           "0.0.5"

# Only supporting centos
supports "centos"

# OpsCode cookbook dependencies
depends "build-essential"
depends "apt" # http://community.opscode.com/cookbooks/apt
depends "apache2" # http://community.opscode.com/cookbooks/apache2
depends "yum"
depends "java"
depends "chef-mongodb"
depends "nginx"
