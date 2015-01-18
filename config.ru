require 'bundler'
Bundler.setup
Bundler.require


class MyApp < Sinatra::Base

  get '/hello/:name' do
    "Hello #{params[:name]}"
  end

  get '/' do
    'Hello'
  end

  post '/books' do
    "POST BOOKS"
  end


end

run MyApp
