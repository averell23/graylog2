maintainer        "Daniel Hahn"
maintainer_email  "foo@bar.org"
license           "Apache 2.0"
description       "Installs and configures Graylog2"
version           "0.1.1"
recipe            "graylog2", "Installs and configures Graylog2"

# Only supporting centos
supports "centos"

# cookbook dependencies
depends "apt" # http://community.opscode.com/cookbooks/apt
depends "ruby_from_source"
depends "yum"
depends "java"
depends "chef-mongodb"
depends "elasticsearch"
