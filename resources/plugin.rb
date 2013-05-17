def initialize(*args)
  super
  @action = :install
end

actions :install

attribute :plugin_name, :kind_of => String, :name_attribute => true
