# frozen_string_literal: true

class Consumer < Sequel::Model
  set_primary_key :id
  unrestrict_primary_key

  many_to_many :repositories, join_table: :consumers_repositories

  def self.populate_from_csv(path)
    begin
      csv_data = read_csv_data(path)
      csv_data.each do |row|
        create(
          id: row['ID'],
          name: row['Name']
        )
      end
      LOG.info("Loaded consumers data from #{path}")
    rescue Exception => e
      LOG.error(e)
    end
  end

end
