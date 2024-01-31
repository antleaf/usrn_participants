require 'sinatra'
require 'haml'

set :haml, { escape_html: false }
set :views, settings.root + '/web/templates'
set :public_folder, settings.root + '/web/assets'
set :site_title, 'USRN Participants'
set :default_survey_id, 'survey-1'

enable :sessions
