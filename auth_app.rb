class AuthApp < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "nljksadlkasjdaskjd;lasdjlkasjdklasjdals;hdasdhsdas;hdyqudqwudajs"

    logger = Log4r::Logger.new "app"
    logger.outputters << Log4r::Outputter.stderr
    file_logger = Log4r::FileOutputter.new('logtest', filename: 'development.log')
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
      id: 1,
      url: 'http://i.imgur.com/LIPAV4D.jpg', title: 'The incredible paintings of Rob Gonsalves 1'},
    {
        id: 2,
     url: 'http://i.imgur.com/y40a93x.jpg', title: 'Image2'},
    {
       id:3,
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

  get '/imgs' do
    erb :'index.html'
  end

  #GET /imgs/1.json /imgs/1.html /imgs/1
  get '/imgs/:id.?:format?' do |imgid, format|
    Images.each do |img|
      if img[:id].to_i == imgid.to_i
        if format == 'json'
          content_type 'text/json'
          return img.to_json
        else #html
          @img = img
          return erb(:"show.html")
        end
      end
    end
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
