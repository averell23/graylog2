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

  it "opens the syslog port" do
    assert `nmap -p 8000 -sU -P0 localhost` =~ /1 host up/
  end

  it "opens the GELF port" do
    assert `nmap -p 12201 -sU -P0 localhost` =~ /1 host up/
  end

  it "enables elasticsearch" do
    service('elasticsearch').must_be_enabled
  end

  it "starts elasticsearch" do
    service('elasticsearch').must_be_running
  end

end