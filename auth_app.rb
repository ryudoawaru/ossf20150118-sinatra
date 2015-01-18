class AuthApp < Sinatra::Base
  Users = [
    {
      email: 'ryudo@5xruby.tw',
      password: '1qaz2wsx'
    },{
      email: 'eddie@5xruby.tw',
      password: '12345678'
    }
  ]
  get '/login' do
    erb :'login.html'
  end
  post '/login' do
    Users.each do |user|
      if user[:email] == params["email"] && user[:password] == params[:password]
        @current_user = user
        return erb(:'login_success.html')
      end
    end
    redirect '/login'
  end
end
