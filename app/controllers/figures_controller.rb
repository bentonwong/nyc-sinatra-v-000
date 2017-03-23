class FiguresController < ApplicationController

  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures' do
    redirect to "/"
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])
    if !params["title"]["name"].empty?
      @figure.titles << Title.find_or_create_by(params["title"])
    elsif !!params["figure"]["title_ids"]
      @figure.titles << params["figure"]["title_ids"].map {|t_id| Title.find_by_id(t_id)}
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.find_or_create_by(params["landmark"])
    elsif !!params["figure"]["landmark_ids"]
      @figure.titles << params["figure"]["landmark_ids"].map {|l_id| Landmark.find_by_id(l_id)}
    end
    @figure.save

  end

end
