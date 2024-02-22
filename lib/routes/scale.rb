class USRNParticipantsApp < Sinatra::Base
  get '/scale/?' do
    @page_title = "Scale of Repository Content"
    @sr = SurveyResponse.where(survey_id: session[:survey_id])
    haml :scale, :layout => :'layout'
  end
end