# frozen_string_literal: true
require 'sinatra/base'

class USRNParticipantsApp < Sinatra::Base
  require './lib/config'
  require './lib/web_sinatra_config'
  require './lib/web_sinatra_helpers'
  require './lib/db'
  require './lib/model'
  require './lib/routes/surveys'
  require './lib/routes/repositories'
  require './lib/routes/consumers'
  require './lib/routes/depositors'
  require './lib/routes/output_types'
  require 'haml'

  set :haml, { escape_html: false }
  set :views, settings.root + '/web/templates'
  set :public_folder, settings.root + '/web/assets'
  set :site_title, 'USRN Participants'
  set :default_survey_id, 'survey-1'
  enable :sessions


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

  run! if app_file == $0
end

