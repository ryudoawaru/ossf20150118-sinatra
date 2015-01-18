require 'bundler'
Bundler.setup
Bundler.require


class MyApp < Sinatra::Base

  get '/' do
    'Hello'
  end


end

run MyApp
