# frozen_string_literal: true
require 'sinatra'
require './lib/config'
require './lib/web_sinatra_config'
require './lib/db'
require './lib/model'


get '/' do
  @page_title = 'Home'
  haml :home, :layout => :'layout'
end

get '/repositories' do
  @page_title = 'All Repositories'
  @repositories = Repository.all
  haml :repositories, :layout => :'layout'
end

get '/repositories/:id' do
  @repository = Repository[params[:id]]
  @page_title = "Repository: #{@repository.name}"
  haml :repository, :layout => :'layout'
end

get '/surveys' do
  @page_title = 'All Surveys'
  @surveys = Survey.all
  haml :surveys, :layout => :'layout'
end

get '/surveys/:id' do
  @survey = Survey[params[:id]]
  @page_title = "Survey: #{@survey.name}"
  haml :survey, :layout => :'layout'
end

get '/survey_responses/:id' do
  @survey_response = SurveyResponse[params[:id]]
  @page_title = "Survey Response: #{@survey_response.repository.name}"
  haml :survey_response, :layout => :'layout'
end

# get '/consumers' do
#   @consumers = Consumer.all
#   @page_title = "All Consumers"
#   haml :consumers, :layout => :'layout'
# end
#
# get '/consumers/:id' do
#   @consumer = Consumer[params[:id]]
#   @page_title = "Consumer: #{@consumer.name}"
#   haml :consumer, :layout => :'layout'
# end
