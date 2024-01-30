# frozen_string_literal: true
require 'sinatra'
require './lib/config'
require './lib/web_sinatra_config'
require './lib/web_sinatra_helpers'
require './lib/db'
require './lib/model'
require './lib/routes/surveys'
require './lib/routes/repositories'
require './lib/routes/consumers'
require './lib/routes/depositors'
require './lib/routes/output_types'

before do
  @surveys = Survey.all
  if session[:survey_id] == nil
    session[:survey_id] = settings.default_survey_id
  end
end

# def responses_for_current_survey
#   SurveyResponse.where(survey_id: session[:survey_id])
# end

get '/' do
  @page_title = 'Home'
  haml :home, :layout => :'layout'
end


