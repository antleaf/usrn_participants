# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  Tech_labels = ['OAI-PMH','Rioxx','OpenAIRE Guidelines','Signposting','ResourceSync','JAV','FAIRICat','CRediT','COUNTER','COAR Vocabularies','COAR Notify']
  get '/technologies/?' do
    @page_title = "Technologies"
    @data_rows = []
    Tech_labels.each do |label|
      data_row = ["<a href=\"/technologies/#{dehumanise(label)}\">#{label}</a>"]
      for i in [:not_aware,:considering,:planning_to_implement,:actively_implementing,:already_implemented,:rejected]
        data_row << eval("SurveyResponse.technologies_#{dehumanise(label)}_#{i.to_s}.count")
      end
      @data_rows << data_row
    end
    haml :technologies, :layout => :'layout'
  end

  get '/technologies/:id' do
    @sr = SurveyResponse.all
    @technology_id = params[:id]
    @sr = SurveyResponse.where(survey_id: session[:survey_id])
    @page_title = "Technology: #{humanise(params[:id])}"
    haml :technology, :layout => :'layout'
  end
end