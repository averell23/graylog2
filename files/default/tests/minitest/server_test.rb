require File.expand_path('../support/helpers', __FILE__)

describe 'graylog2::server' do
  
  include Helpers::Betterplace

  it "starts mongo" do
    service('mongod').must_be_running
  end

  it "enables mongo" do
    service('mongod').must_be_enabled
  end

  it "enables graylog" do
    service('graylog2').must_be_enabled
  end

  it "starts graylog" do
    assert `ps aux` =~ /graylog2-server/
  end

end