require './framework'

class MyApp < Framework
 
  get /\/books\/(\d+?)$/ do |id|
    "This is book id: #{id}"
  end
  
  get /\/hello/ do
    'Hello'
  end
  

end

run MyApp
