require 'bundler/setup'
require 'sinatra'

class Sniffit < Sinatra::Base
  put '/api/:device/linked_to/:tag' do
    @links ||= {}
    @links[device] = tag
    200
  end
end
