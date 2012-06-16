require 'bundler/setup'
require 'sinatra'

class Sniffit < Sinatra::Base
  put '/api/:device/linked_to/:tag' do
    @links ||= {}
    @links[params[:device]] = params[:tag]
    200
  end

  put '/api/:device/lost_link_to/:tag' do
    @links ||= {}
    @links[params[:device]] = nil
    200
  end
end
