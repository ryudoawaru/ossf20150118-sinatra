class ImgList < Sinatra::Base

  Images = {
    "1" => {
      url: 'http://i.imgur.com/LIPAV4D.jpg', title: 'The incredible paintings of Rob Gonsalves 1'},
    "2" => {
     url: 'http://i.imgur.com/y40a93x.jpg', title: 'Image2'},
    "3" => {
      url: 'http://i.imgur.com/hswP6Mz.png', title: 'A moment of silence'
    }
  }

  get '/imgs' do
    erb :'index.html'
  end

  get '/imgs/:id' do |imgid|
    Images.each do |id, img|
      if id.to_i == imgid.to_i
        @img = img
        break
      end
    end
    erb :'show.html'
  end



end
