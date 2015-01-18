class ImgList < Sinatra::Base

  Images = [
    {
      id: 1,
      url: 'http://i.imgur.com/LIPAV4D.jpg', title: 'The incredible paintings of Rob Gonsalves 1'},
    {
     id: 2,
     url: 'http://i.imgur.com/y40a93x.jpg', title: 'Image2'},
    {
       id: 3,
      url: 'http://i.imgur.com/hswP6Mz.png', title: 'A moment of silence'
    }
  ]

  get '/imgs' do
    erb :'index.html'
  end

  get '/imgs/:id' do
    Images.each do |img|
      p img
      p params[:id]
      if img[:id] == params[:id].to_i
        @img = img
        break
      end
    end
    erb :'show.html'
  end



end
