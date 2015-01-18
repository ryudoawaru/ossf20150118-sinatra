class ImgList < Sinatra::Base

  Images = [
    {url: 'http://i.imgur.com/LIPAV4D.jpg', title: 'The incredible paintings of Rob Gonsalves 1'},
    {url: 'http://i.imgur.com/y40a93x.jpg', title: 'Image2'},
    {
      url: 'http://i.imgur.com/hswP6Mz.png', title: 'A moment of silence'
    }
  ]

  get '/imgs' do
    erb :'index.html'
  end



end
