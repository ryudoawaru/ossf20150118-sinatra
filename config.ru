require './framework'

class MyApp < Framework
  
  get '/' do
    'You are in root path.'
  end
  
  get '/hello' do
    'Hello'
  end
  

end

run MyApp