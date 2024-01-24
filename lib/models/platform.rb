# frozen_string_literal: true

class Platform < Sequel::Model
  set_primary_key :id
  unrestrict_primary_key

  one_to_many :repositories

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
      LOG.info("Loaded platform data from #{path}")
    rescue Exception => e
      LOG.error(e)
    end
  end
end