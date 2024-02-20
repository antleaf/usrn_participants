# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  get '/technologies/?' do
    @page_title = "Technologies"
    @tech_labels = ['OAI-PMH','Rioxx','OpenAIRE Guidelines','Signposting','ResourceSync','JAV','FAIRICat','CRediT','COUNTER','COAR Vocabularies','COAR Notify']
    @data_rows = []
    @tech_labels.each do |label|
      data_row = [label]
      for i in [:not_aware,:considering,:planning_to_implement,:actively_implementing,:already_implemented,:rejected]
        data_row << eval("SurveyResponse.technologies_#{label.gsub(/[\s-]/,'_').downcase}_#{i.to_s}.count")
      end
      @data_rows << data_row
    end
    haml :technologies, :layout => :'layout'
  end

  # get '/technologies/:id' do
  #   @technology = Depositor[params[:id]]
  #   @repositories = @technology.survey_responses.map { |r| r.repository }
  #   @page_title = "Technology: #{@depositor.name}"
  #   haml :technology, :layout => :'layout'
  # end
end