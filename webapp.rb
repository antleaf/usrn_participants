# frozen_string_literal: true
require 'sinatra/base'
require './lib/web_sinatra_helpers'
require './lib/config'
require './lib/db'
require './lib/model'
require './lib/routes/surveys'
require './lib/routes/repositories'
require './lib/routes/consumers'
require './lib/routes/depositors'
require './lib/routes/output_types'
require 'haml'
require 'dotenv/load'

class USRNParticipantsApp < Sinatra::Base
  set :haml, { escape_html: false }
  set :views, settings.root + '/../web/templates'
  set :public_folder, settings.root + '/../web/assets'
  set :site_title, 'USRN Participant Survey'
  set :default_survey_id, 'survey-1'
  enable :logging
  enable :sessions
  use Rack::Auth::Basic do |username, password|
    username == ENV.fetch('APP_USERNAME', nil) && password == ENV.fetch('APP_PASSWORD', nil)
  end
  # configure :production, :development do
  #
  # end

  before do
    @surveys = Survey.all
    if session[:survey_id] == nil
      session[:survey_id] = settings.default_survey_id
    end
  end

  get '/' do
    @page_title = 'Home'
    haml :home, :layout => :'layout'
  end

  # run! if app_file == $0
end

