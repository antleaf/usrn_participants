# frozen_string_literal: true
require 'sinatra'
require './lib/config'
require './lib/web_sinatra_config'
require './lib/db'
require './lib/model'

before do
  @surveys = Survey.all
  if session[:survey_id] == nil
    session[:survey_id] = settings.default_survey_id
  end
end

def responses_for_current_survey
  SurveyResponse.where(survey_id: session[:survey_id])
end

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
  @survey_response = SurveyResponse.where(repository_id: @repository.id, survey_id: session[:survey_id]).first
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

post '/surveys' do
  session[:survey_id] = params[:survey_id]
  redirect '/surveys'
end

get '/consumers' do
  @consumers = Consumer.all
  @page_title = "All Consumers"
  haml :consumers, :layout => :'layout'
end

get '/consumers/:id' do
  @consumer = Consumer[params[:id]]
  @repositories = @consumer.survey_responses.map { |r| r.repository }
  @page_title = "Consumer: #{@consumer.name}"
  haml :consumer, :layout => :'layout'
end
