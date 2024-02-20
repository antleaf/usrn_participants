# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  get '/users/?' do
    @depositors = Depositor.all
    @consumers = Consumer.all
    @page_title = "Users"
    haml :users, :layout => :'layout'
  end

end