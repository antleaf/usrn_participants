require 'sinatra'
require 'haml'

class USRNParticipantsApp < Sinatra::Base
  set :haml, { escape_html: false }
  set :views, settings.root + '/web/templates'
  set :public_folder, settings.root + '/web/assets'
  set :site_title, 'USRN Participants'
  set :default_survey_id, 'survey-1'
  enable :logging
  enable :sessions
  # configure :production, :development do
  #
  # end
end