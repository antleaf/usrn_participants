class USRNParticipantsApp < Sinatra::Base
  get '/awareness/?' do
    @page_title = "Awareness"
    @sr = SurveyResponse.where(survey_id: session[:survey_id])
    haml :awareness, :layout => :'layout'
  end
end