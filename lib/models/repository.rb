# frozen_string_literal: true

class Repository < Sequel::Model
  set_primary_key :id
  unrestrict_primary_key

  many_to_one :platform
  one_to_many :survey_responses

  def self.populate_from_csv(path)
    begin
      csv_data = read_csv_data(path)
      csv_data.each do |row|
        create(
          id: row['ID'],
          name: row['Name'],
          url: row['URL'],
          owner: row['Owner'],
          platform: Platform[row['Platform']],
          version: row['Version'],
          notes: row['Notes']
        )
      end
      LOG.info("Loaded repository data from #{path}")
    rescue Exception => e
      LOG.error(e)
    end
  end
end

