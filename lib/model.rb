require 'open-uri'
require 'csv'
require 'sequel'
require 'time'

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
    rescue Exception => e
      LOG.error(e)
    end
  end
end

class Repository < Sequel::Model
  set_primary_key :id
  unrestrict_primary_key

  many_to_one :platform

  def self.populate_from_csv(path)
    begin
      csv_data = read_csv_data(path)
      csv_data.each do |row|
        create(
          id: row['ID'],
          name: row['Name'],
          url: row['URL'],
          owner: row['Owner'],
          platform: Platform[(row['Platform'])],
          version: row['Version'],
          notes: row['Notes']
        )
      end
    rescue Exception => e
      LOG.error(e)
    end
  end
end

# class Repository < Sequel::Model
#   set_primary_key :id
#   unrestrict_primary_key
#
#   # many_to_one :status
#
#   # def self.publishable
#   #   where(:publish => true)
#   # end
#
#   # def self.section_name
#   #   @@name
#   # end
#
#   def self.populate_from_csv()
#     csv_data = read_csv_data('repositories_master')
#     csv_data.each do |row|
#       create(
#         id: row['Repository ID'],
#         full_name: row['Full Name']
#       )
#     end
#   end
# end

def populate_db_from_csv(csv_data_folder)
  Platform.populate_from_csv("#{csv_data_folder}/platforms.csv")
  Repository.populate_from_csv("#{csv_data_folder}/repositories.csv")
end

def read_csv_data(path)
  csv_data = nil
  begin
    csv_data = CSV.read(path, :headers => true, :encoding => 'UTF-8')
    LOG.info("Loaded platform data from #{path}")
  rescue Exception => e
    raise
  end
  csv_data
end