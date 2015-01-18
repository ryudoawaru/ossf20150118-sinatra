require 'bundler'
Bundler.setup
Bundler.require
require './framework'


class MyApp < Framework
 
  get /\/books\/(\d+?)$/ do |id|
    render 'show.html', id: id
  end
  
  get /\/hello/ do
    'Hello'
  end
  

end

run MyApp
