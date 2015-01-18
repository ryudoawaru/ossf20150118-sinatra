require 'bundler'
Bundle.setup
Bundle.require
require './framework'


class MyApp < Framework
 
  get /\/books\/(\d+?)$/ do |id|
    p request
    "This is book id: #{id}, foo = #{params['foo']}"
  end
  
  get /\/hello/ do
    'Hello'
  end
  

end

run MyApp
