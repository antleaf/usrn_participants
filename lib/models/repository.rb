# frozen_string_literal: true

class Repository < Sequel::Model
  set_primary_key :id
  unrestrict_primary_key

  many_to_one :platform
  many_to_many :output_types, join_table: :output_types_repositories

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

  def self.load_survey_responses(path)
    begin
      csv_data = read_csv_data(path)
      csv_data.each do |row|
        repo = Repository[row['ID']]
        if repo
          repo.role = row[4]
          repo.other_output_types = row[5]
          if repo.other_output_types.include?('Research papers')
            repo.add_output_type(OutputType['research-papers'])
          end
          if repo.other_output_types.include?('Data-sets')
            repo.add_output_type(OutputType['datasets'])
          end
          if repo.other_output_types.include?('Software (source code)')
            repo.add_output_type(OutputType['software'])
          end
          repo.save
        end
      end
      LOG.info("Loaded survey data from #{path} into repositories")
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
