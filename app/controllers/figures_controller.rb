require_relative '../../config/environment'
require 'pry'

class FiguresController < ApplicationController

  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    redirect to '/figures'
  end

  get '/figures' do
    @figures = Figure.all.map {|figure_obj| figure_obj.name}
    erb :'/figures/index'
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

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end

end
