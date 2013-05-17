def initialize(*args)
  super
  @action = :install
end

actions :install

attribute :name, :kind_of => String, :name_attribute => true
attribute :version, :kind_of => String
