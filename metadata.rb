maintainer        "Daniel Hahn"
maintainer_email  "foo@bar.org"
license           "Apache 2.0"
description       "Installs and configures Graylog2"
version           "0.0.5"
recipe            "graylog2", "Installs and configures Graylog2"

# Only supporting centos
supports "centos"

# cookbook dependencies
depends "apt" # http://community.opscode.com/cookbooks/apt
depends "rails_install"
depends "yum"
depends "java"
depends "chef-mongodb"