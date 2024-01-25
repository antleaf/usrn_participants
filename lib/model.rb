require 'open-uri'
require 'csv'
require 'sequel'
require 'time'
require './lib/models/platform'
require './lib/models/repository'
require './lib/models/output_type'
require './lib/models/depositor'
require './lib/models/consumer'
require './lib/utilities'

def populate_db_from_csv(csv_data_folder)
  Consumer.populate_from_csv("#{csv_data_folder}/consumers.csv")
  Depositor.populate_from_csv("#{csv_data_folder}/depositors.csv")
  OutputType.populate_from_csv("#{csv_data_folder}/output_types.csv")
  Platform.populate_from_csv("#{csv_data_folder}/platforms.csv")
  Repository.populate_from_csv("#{csv_data_folder}/repositories.csv")
  Repository.load_survey_responses("#{csv_data_folder}/survey_responses.csv")
end
