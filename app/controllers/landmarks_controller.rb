require_relative '../../config/environment'
require 'pry'

class LandmarksController < ApplicationController

  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    @landmark = Landmark.create(params["landmark"])
    @landmark.save
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/edit'
  end

  post '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    if !params["landmark"]["name"].empty?
      @landmark.name = params["landmark"]["name"]
    end
    if !params["landmark"]["year_completed"].empty?
      @landmark.year_completed = params["landmark"]["year_completed"].to_i
    end
    @landmark.save
    redirect to "/landmarks/#{params[:id]}"
  end

end
