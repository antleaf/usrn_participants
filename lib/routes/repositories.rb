# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  get '/repositories/?' do
    @page_title = 'Repositories'
    @repositories = Repository.all
    haml :repositories, :layout => :'layout'
  end

  get '/repositories/:id' do
    @repository = Repository[params[:id]]
    @sr = SurveyResponse.where(repository_id: @repository.id, survey_id: session[:survey_id]).first
    @page_title = "Repository: #{@repository.name}"
    haml :repository, :layout => :'layout'
  end
end