require 'open-uri'
require 'csv'
require 'sequel'
require 'time'
require './lib/models/platform'
require './lib/models/repository'
require './lib/models/output_type'
require './lib/models/depositor'
require './lib/models/consumer'
require './lib/models/survey'
require './lib/models/survey_response'
require './lib/utilities'

def populate_db_from_csv(csv_data_folder)
  Consumer.populate_from_csv("#{csv_data_folder}/consumers.csv")
  Depositor.populate_from_csv("#{csv_data_folder}/depositors.csv")
  OutputType.populate_from_csv("#{csv_data_folder}/output_types.csv")
  Platform.populate_from_csv("#{csv_data_folder}/platforms.csv")
  Repository.populate_from_csv("#{csv_data_folder}/repositories.csv")
  Survey.populate_from_csv("#{csv_data_folder}/surveys.csv")
  Survey.all.each do |survey|
    SurveyResponse.populate_from_csv(survey.id,"#{csv_data_folder}/#{survey.id}_responses.csv")
    SurveyResponse.update_record_count_data(survey.id,"#{csv_data_folder}/repository_record_counts.csv")
  end
end
