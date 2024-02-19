#!/usr/local/env ruby
require './lib/config'
if ARGV[0] == 'resetdb'
  RESET_DB = true
end

require './lib/db'
require './lib/model'

LOG.info("Process starting")

if RESET_DB then
  LOG.info("Resetting DB...")
  populate_db_from_csv(CSV_DATA_FOLDER)
end

LOG.info("Process completed")