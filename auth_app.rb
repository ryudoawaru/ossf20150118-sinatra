class AuthApp < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "nljksadlkasjdaskjd;lasdjlkasjdklasjdals;hdasdhsdas;hdyqudqwudajs"

    logger = Log4r::Logger.new "app"
    logger.outputters << Log4r::Outputter.stderr
    file_logger = Log4r::FileOutputter.new('logtest', filename: 'development.log')
    #file_logger.formatter = Log4r::PatternFormatter.new(pattern: ' [%1] %d :: %m ')
    logger.outputters << file_logger

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

  helpers do
    def logger
      @logger ||= Log4r::Logger['app']
    end
  end

  before do
    logger.info "#### BEFORE BLOCK########"
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
