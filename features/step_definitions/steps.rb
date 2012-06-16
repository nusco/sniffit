require 'bundler/setup'
require 'rest_client'
require 'rspec'

#SERVER = "http://sniffit.heroku.com"
SERVER = "http://localhost:9292"

Before do
  @device = @tag = nil
  RestClient.delete "#{SERVER}\/"
end

When /^I have a device with id "(.*?)" and a tag "(.*?)"$/ do |device, tag|
  @device, @tag = device, tag
end

When /^I have a device with id "(.*?)" and a paired tag "(.*?)"$/ do |device, tag|
  @device, @tag = device, tag
  @response = RestClient.put "#{SERVER}\/api/#{device}/linked_to/#{tag}", {}
end

Then /^I HTTP PUT to http:\/\/sniffit\.heroku\.com\/(.*?)$/ do |url|
  @response = RestClient.put "#{SERVER}\/#{url}", {}
end

When /^somebody does an HTTP PUT to http:\/\/sniffit\.heroku\.com\/api\/device_at\/(\d+\.\d+)\/(\d+\.\d+)\/found\/(.*?)$/ do |lat, long, tag|
  @lat, @long = lat, long
  @response = RestClient.put "#{SERVER}\/api/device_at/#{lat}/#{long}/found/#{tag}", {}  
end

When /^I lose the link to the tag$/ do
  @response = RestClient.put "#{SERVER}\/api/#{@device}/lost_link_to/#{@tag}", {}
end

When /^I've lost the link to the tag$/ do
  @response = RestClient.put "#{SERVER}\/api/#{@device}/lost_link_to/#{@tag}", {}
end

When /^the user confirms that the tag is lost$/ do
end

When /^I have a device located at (\d+\.\d+), (\d+\.\d+)$/ do |lat, long|
  @lat, @long = lat, long
end

When /^I pick up a broadcast from a tag with id "(.*?)"$/ do |id|
end

Then /^I poll HTTP GET http:\/\/sniffit\.heroku\.com\/(.*?)$/ do |url|
  begin
    @response = RestClient.get "#{SERVER}\/#{url}"
    @return_code = @response.code
  rescue Exception => e
    @return_code = 404
  end
end

Then /^I get a (\d+)$/ do |return_code|
  @return_code.to_s.should == return_code
end

Then /^I see the geospatial data of the lost device in the response$/ do
  @response.body.should == "#{@lat},#{@long}"
end
