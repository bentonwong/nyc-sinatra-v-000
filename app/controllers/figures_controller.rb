class FiguresController < ApplicationController

  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    erb :index
  end

  get '/figures' do
    redirect to '/'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(params["title"])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(params["landmark"])
    end
    @figure.save

  end

end
