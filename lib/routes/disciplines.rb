class USRNParticipantsApp < Sinatra::Base
  get '/disciplines/?' do
    @page_title = "Disciplines"
    @sr = SurveyResponse.where(survey_id: session[:survey_id])
    haml :disciplines, :layout => :'layout'
  end
end