require 'bundler/setup'
require 'sinatra'

class Sniffit < Sinatra::Base
  get '/' do
    "hello, world"
  end
end
