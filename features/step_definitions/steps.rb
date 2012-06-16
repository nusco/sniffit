require 'bundler/setup'
require 'rest_client'
require 'rspec'

#SERVER = "http://sniffit.heroku.com"
SERVER = "http://localhost:9292"

Before do
  @device = @tag = nil
  RestClient.delete "#{SERVER}\/"
end

When /^I have a device that wants to link to a tag "(.*?)"$/ do |tag|
  @tag = tag
end

When /^I have a device linked to a tag "(.*?)"$/ do |tag|
  @tag = tag
  @response = RestClient.put "#{SERVER}/api/#{tag}/linked", {}
end

Then /^I HTTP PUT to (.*?)$/ do |url|
  @response = RestClient.put "#{SERVER}#{url}", {}
end

When /^somebody does an HTTP PUT to \/api\/(.*?)\/found_at\/(.*?)$/ do |tag, latlong|
  @latlong = latlong
  @response = RestClient.put "#{SERVER}\/api/#{tag}/found_at/#{latlong}", {}  
end

When /^I(.*?) sight of the tag at (.*?)$/ do |_, latlong|
  @response = RestClient.put "#{SERVER}\/api/#{@tag}/lost_at/#{latlong}", {}
end

When /^the user confirms that the tag is lost$/ do
end

When /^I have a device located at (.*?)$/ do |latlong|
  @latlong = latlong
end

When /^I pick up a broadcast from a tag with id "(.*?)"$/ do |id|
end

Then /^I poll HTTP GET (.*?)$/ do |url|
  begin
    @response = RestClient.get "#{SERVER}#{url}"
    @return_code = @response.code
  rescue Exception => e
    @return_code = 404
  end
end

Then /^I get a (\d+)$/ do |return_code|
  @return_code.to_s.should == return_code
end

Then /^I see the geospatial data of the lost device in the response$/ do
  @response.body.should == "#{@latlong}"
end
