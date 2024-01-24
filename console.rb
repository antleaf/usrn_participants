#!/usr/local/env ruby
require './lib/config'
require './lib/db'
require './lib/model'

LOG.info("Process starting")

if RESET_DB then
  populate_db_from_csv(CSV_DATA_FOLDER)
end


LOG.info("Process completed")