# frozen_string_literal: true

class Survey < Sequel::Model
  set_primary_key :id
  unrestrict_primary_key

  one_to_many :survey_responses

  def self.populate_from_csv(path)
    begin
      csv_data = read_csv_data(path)
      csv_data.each do |row|
        create(
          id: row['ID'],
          name: row['Name'],
          notes: row['Notes']
        )
      end
      LOG.info("Loaded survey data from #{path}")
    rescue Exception => e
      LOG.error(e)
    end
  end
end