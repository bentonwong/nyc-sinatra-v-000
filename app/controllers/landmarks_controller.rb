require_relative '../../config/environment'
require 'pry'

class LandmarksController < ApplicationController

  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

end
