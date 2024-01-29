require 'sinatra'
require 'haml'

# require 'will_paginate'
# require 'will_paginate/sequel'

# Sequel::Model.db.extension(:pagination)

# set :haml, :format => :html5
set :haml, { escape_html: false }
set :views, settings.root + '/web/templates'
set :public_folder, settings.root + '/web/assets'
set :site_title, 'USRN Participants'

set :default_survey_id, 'survey-1'

enable :sessions
