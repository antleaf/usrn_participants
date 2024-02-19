require 'sinatra'
require 'haml'
require 'dotenv/load'

class USRNParticipantsApp < Sinatra::Base
  set :haml, { escape_html: false }
  set :views, settings.root + '/web/templates'
  set :public_folder, settings.root + '/web/assets'
  set :site_title, 'USRN Participants'
  set :default_survey_id, 'survey-1'
  enable :logging
  enable :sessions
  use Rack::Auth::Basic do |username, password|
    username == ENV.fetch('APP_USERNAME', nil) && password == ENV.fetch('APP_PASSWORD', nil)
  end
  # configure :production, :development do
  #
  # end
end