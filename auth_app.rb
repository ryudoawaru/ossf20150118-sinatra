class AuthApp < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "nljksadlkasjdaskjd;lasdjlkasjdklasjdals;hdasdhsdas;hdyqudqwudajs"
  end

  Users = [
    {
      email: 'ryudo@5xruby.tw',
      password: '1qaz2wsx'
    },{
      email: 'eddie@5xruby.tw',
      password: '12345678'
    }
  ]

  Images = [
    {
      url: 'http://i.imgur.com/LIPAV4D.jpg', title: 'The incredible paintings of Rob Gonsalves 1'},
    {
     url: 'http://i.imgur.com/y40a93x.jpg', title: 'Image2'},
    {
      url: 'http://i.imgur.com/hswP6Mz.png', title: 'A moment of silence'
    }
  ]

  before do
    @current_user = session[:current_user]
  end

  before '/imgs' do
    unless session[:current_user]
      halt 'Not authorized'
    end
  end

  get '/imgs' do
    erb :'index.html'
  end

  get '/login' do
    erb :'login.html'
  end
  post '/login' do
    Users.each do |user|
      if user[:email] == params["email"] && user[:password] == params[:password]
        @current_user = user
        session[:current_user] = user
        return erb(:'login_success.html')
      end
    end
    redirect '/login'
  end
end
