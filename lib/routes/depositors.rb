# frozen_string_literal: true

get '/depositors' do
  @depositors = Depositor.all
  @page_title = "All Depositors"
  haml :depositors, :layout => :'layout'
end

get '/depositors/:id' do
  @depositor = Depositor[params[:id]]
  @repositories = @depositor.survey_responses.map { |r| r.repository }
  @page_title = "Depositor: #{@depositor.name}"
  haml :depositor, :layout => :'layout'
end