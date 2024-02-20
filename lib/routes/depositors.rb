# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  get '/depositors' do
    @depositors = Depositor.all
    @page_title = "Depositors"
    haml :depositors, :layout => :'layout'
  end

  get '/depositors/:id' do
    @depositor = Depositor[params[:id]]
    @repositories = @depositor.survey_responses.map { |r| r.repository }
    @page_title = "Depositor: #{@depositor.name}"
    haml :depositor, :layout => :'layout'
  end
end