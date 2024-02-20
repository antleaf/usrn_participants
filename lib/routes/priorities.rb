class USRNParticipantsApp < Sinatra::Base
  Priority_labels = ['Avoid duplication','Capture metadata','Increase discoverability','Keeping track','Machine accessible','Populate PIDs','Timely OA']
  get '/priorities/?' do
    @priority_labels = Priority_labels
    @page_title = "Priorities"
    @data_rows = []
    Priority_labels.each do |label|
      data_row = ["<a href=\"/priorities/#{dehumanise(label)}\">#{label}</a>"]
      for i in [:strongly_disagree,:disagree,:neutral,:agree,:strongly_agree]
        data_row << eval("SurveyResponse.mission_#{dehumanise(label)}_#{i.to_s}.count")
      end
      @data_rows << data_row
    end
    @sr = SurveyResponse.where(survey_id: session[:survey_id])
    haml :priorities, :layout => :'layout'
  end

  get '/priorities/:id' do
    @sr = SurveyResponse.all
    @priority_id = params[:id]
    @sr = SurveyResponse.where(survey_id: session[:survey_id])
    @page_title = "Priority: #{humanise(params[:id])}"
    haml :priority, :layout => :'layout'
  end
end