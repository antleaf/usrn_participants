require 'open-uri'
require 'csv'
require 'sequel'
require 'time'
require './lib/models/platform'
require './lib/models/repository'
require './lib/models/output_type'

def populate_db_from_csv(csv_data_folder)
  OutputType.populate_from_csv("#{csv_data_folder}/output_types.csv")
  Platform.populate_from_csv("#{csv_data_folder}/platforms.csv")
  Repository.populate_from_csv("#{csv_data_folder}/repositories.csv")
  Repository.load_survey_responses("#{csv_data_folder}/survey_responses.csv")
end

def read_csv_data(path)
  csv_data = nil
  begin
    csv_data = CSV.read(path, :headers => true, :encoding => 'UTF-8')
  rescue Exception => e
    raise
  end
  csv_data
end