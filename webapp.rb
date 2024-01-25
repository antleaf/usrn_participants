# frozen_string_literal: true
require 'sinatra'
require './lib/config'
require './lib/web_sinatra_config'
require './lib/db'
require './lib/model'


get '/' do
  haml :home, :layout => :'layout'
end

get '/repositories' do
  @repositories = Repository.all
  haml :repositories, :layout => :'layout'
end

get '/repositories/:id' do
  @repository = Repository[params[:id]]
  haml :repository, :layout => :'layout'
end