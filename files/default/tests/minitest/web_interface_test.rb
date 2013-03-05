require File.expand_path('../support/helpers', __FILE__)

describe 'graylog2::web_interface' do
  
  include Helpers::Betterplace

  let(:app_dir) { "/var/graylog2/web" }

  it "install the mongoid.yml file to shared" do
    file("#{app_dir}/config/mongoid.yml").must_exist
  end

  it "links the mongoid.yml to the config dir" do
    file("#{app_dir}/config/mongoid.yml").must_exist
  end

  it "install the general.yml file to shared" do
    file("#{app_dir}/config/general.yml").must_exist
  end

  it "links the general.yml to the config dir" do
    file("#{app_dir}/config/general.yml").must_exist
  end

end