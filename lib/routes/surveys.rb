# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  get '/surveys/?' do
    @page_title = 'Surveys'
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
end