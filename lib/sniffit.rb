require 'bundler/setup'
require 'sinatra'

$TAG_LOCATION = {}
$LOST_TAGS = []

class Sniffit < Sinatra::Base
  get '/' do
    [200, {"Content-Type" => "text/plain"}, File.read('features/tags_and_devices.feature')]
  end
  
  delete '/' do
    $LOST_TAGS.clear
    $TAG_LOCATION.clear
  end

  put '/api/:tag/linked' do
  end

  put '/api/:tag/lost_at/:latlong' do |tag, latlong|
    $LOST_TAGS << tag
    $TAG_LOCATION[tag] = latlong
    200
  end
  
  put '/api/:tag/found_at/:latlong' do |tag, latlong|
    $LOST_TAGS.delete tag
    $TAG_LOCATION[tag] = latlong
    200
  end
  
  get '/api/lost_tags/:tag' do |tag|
    if $LOST_TAGS.include? tag
      404
    else
      [200, {}, $TAG_LOCATION[tag]]
    end
  end
end
