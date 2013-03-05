require File.expand_path('../support/helpers', __FILE__)

describe 'graylog2::web_interface_source_ruby' do
  
  include Helpers::Betterplace

  # Seems we can't check for the service, sine it uses
  # nondefault upstart

  it "opens the web port" do
    assert `nmap -p 8000 -sU -P0 localhost` =~ /1 host up/
  end

end