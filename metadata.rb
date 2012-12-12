maintainer        "Betterplace.org"
maintainer_email  "developers@betterplace.org"
license           "Apache 2.0"
description       "Installs and configures Graylog2"
version           "0.0.6"

# Only supporting centos
supports "centos"

# OpsCode cookbook dependencies
depends "elasticsearch"
depends "build-essential"
depends "apt" # http://community.opscode.com/cookbooks/apt
depends "apache2" # http://community.opscode.com/cookbooks/apache2
depends "yum"
depends "java"
depends "chef-mongodb"
depends "nginx"
