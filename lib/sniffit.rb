require 'bundler/setup'
require 'sinatra'

$TAG_LOCATION = {}

class Sniffit < Sinatra::Base
  get '/' do
    [200, {"Content-Type" => "text/plain"}, File.read('features/tags_and_devices.feature')]
  end
  
  delete '/' do
    $TAG_LOCATION = {}
  end

  put '/api/:device/linked_to/:tag' do |device, tag|
    $TAG_LOCATION[tag] = [0, 0]
    200
  end

  put '/api/:device/lost_link_to/:tag' do |device, tag|
    $TAG_LOCATION[tag] = nil
    200
  end
  
  put '/api/:tag/found_at/:latlong' do |tag, latlong|
    $TAG_LOCATION[tag] = latlong
    200
  end
  
  get '/api/lost_tags/:tag' do |tag|
    location = $TAG_LOCATION[tag]
    return 404 unless location
    [200, {}, location]
  end
end
