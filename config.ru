require 'bundler'
Bundler.setup
Bundler.require
require './framework'


class MyApp < Framework
 
  get /\/books\/(\d+?)$/ do |id|
    render 'show.html', layout_path: 'views/layout2.erb', locals: {id: id}
  end
  
  get /\/hello/ do
    'Hello'
  end
  

end

run MyApp
