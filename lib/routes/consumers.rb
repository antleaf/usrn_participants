# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  get '/consumers/?' do
    @consumers = Consumer.all
    @page_title = "Consumers"
    haml :consumers, :layout => :'layout'
  end

  get '/consumers/:id' do
    @consumer = Consumer[params[:id]]
    @repositories = @consumer.survey_responses.map { |r| r.repository }
    @page_title = "Consumer: #{@consumer.name}"
    haml :consumer, :layout => :'layout'
  end
end