# frozen_string_literal: true

class Repository < Sequel::Model
  plugin :enum
  set_primary_key :id
  unrestrict_primary_key

  many_to_one :platform
  many_to_many :output_types, join_table: :output_types_repositories
  many_to_many :depositors, join_table: :depositors_repositories
  many_to_many :consumers, join_table: :consumers_repositories

  enum :mission_keeping_track, strongly_disagree: 1, disagree: 2, neutral: 3, agree: 4, strongly_agree: 5, prefix: true
  enum :mission_increase_discoverability, strongly_disagree: 1, disagree: 2, neutral: 3, agree: 4, strongly_agree: 5, prefix: true
  enum :mission_capture_metadata, strongly_disagree: 1, disagree: 2, neutral: 3, agree: 4, strongly_agree: 5, prefix: true
  enum :mission_avoid_duplication, strongly_disagree: 1, disagree: 2, neutral: 3, agree: 4, strongly_agree: 5, prefix: true
  enum :mission_populate_pids, strongly_disagree: 1, disagree: 2, neutral: 3, agree: 4, strongly_agree: 5, prefix: true
  enum :mission_timely_oa, strongly_disagree: 1, disagree: 2, neutral: 3, agree: 4, strongly_agree: 5, prefix: true
  enum :mission_machine_accessible, strongly_disagree: 1, disagree: 2, neutral: 3, agree: 4, strongly_agree: 5, prefix: true

  enum :coar_framework_awareness, not_aware: 1, aware: 2, considering: 3, implementing: 4, already_implemented: 5, prefix: true

  enum :pid_minting, not_yet_but_planning_to: 1, always: 2, sometimes: 3, never: 4, dont_know: 5, prefix: true

  enum :fair_awareness, not_aware: 1, vaguely_aware: 2, considering: 3, actively_working: 4, not_relevant: 5, prefix: true

  enum :technologies_oai_pmh, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_rioxx, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_openaire_guidelines, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_signposting, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_resourcesync, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_coar_notify, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_coar_vocabularies, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_jav, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_credit, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_counter, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true
  enum :technologies_fairicat, not_aware: 1, considering: 2, planning_to_implement: 3, actively_implementing: 4, already_implemented: 5, rejected: 6, prefix: true



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

          choices = OutputType.map { |x| x.name }
          choices.each do |choice|
            if repo.other_output_types.include?(choice)
              repo.add_output_type(OutputType.first(name: choice))
            end
          end

          repo.disciplines = row[6]

          repo.other_depositors = row[7]
          choices = Depositor.map { |x| x.name }
          choices.each do |choice|
            if repo.other_depositors.include?(choice)
              repo.add_depositor(Depositor.first(name: choice))
            end
          end

          repo.other_consumers = row[8]
          choices = Consumer.map { |x| x.name }
          choices.each do |choice|
            if repo.other_consumers.include?(choice)
              repo.add_consumer(Consumer.first(name: choice))
            end
          end

          repo.policies = row[9]

          repo.mission_keeping_track = get_enum_form_of_sheet_value(row[10])
          repo.mission_increase_discoverability = get_enum_form_of_sheet_value(row[11])
          repo.mission_capture_metadata = get_enum_form_of_sheet_value(row[12])
          repo.mission_avoid_duplication = get_enum_form_of_sheet_value(row[13])
          repo.mission_populate_pids = get_enum_form_of_sheet_value(row[14])
          repo.mission_timely_oa = get_enum_form_of_sheet_value(row[15])
          repo.mission_machine_accessible = get_enum_form_of_sheet_value(row[16])

          repo.nelson_awareness = row[17]
          repo.institutional_priority_challenges = row[18]
          repo.service_management = row[19]
          repo.software_management = row[20]
          repo.technical_expertise = row[21]

          repo.coar_framework_awareness = get_enum_form_of_sheet_value(row[22])

          repo.management_challenges = row[23]
          repo.cris = row[24]
          repo.existing_integrations = row[25]
          repo.metadata_records = row[26]
          repo.content_items = row[27]
          repo.pid_minting = get_enum_form_of_sheet_value(row[28])
          repo.technical_challenges = row[29]
          repo.innovation_appetite = row[30]

          case row[31]
          when 'Not aware of FAIR'
            repo.fair_awareness = :not_aware
          when 'Vaguely aware of FAIR'
            repo.fair_awareness = :vaguely_aware
          when 'Considering how to adopt the FAIR principles'
            repo.fair_awareness = :considering
          when 'Actively working to adopt FAIR principles'
            repo.fair_awareness = :actively_working
          when 'Do not think FAIR is relevant/useful'
            repo.fair_awareness = :not_relevant
          end

          repo.technologies_oai_pmh = get_enum_for_technology_sheet_value(row[32])
          repo.technologies_rioxx = get_enum_for_technology_sheet_value(row[33])
          repo.technologies_openaire_guidelines = get_enum_for_technology_sheet_value(row[34])
          repo.technologies_signposting = get_enum_for_technology_sheet_value(row[35])
          repo.technologies_resourcesync = get_enum_for_technology_sheet_value(row[36])
          repo.technologies_coar_notify = get_enum_for_technology_sheet_value(row[37])
          repo.technologies_coar_vocabularies = get_enum_for_technology_sheet_value(row[38])
          repo.technologies_jav = get_enum_for_technology_sheet_value(row[39])
          repo.technologies_credit = get_enum_for_technology_sheet_value(row[40])
          repo.technologies_counter = get_enum_for_technology_sheet_value(row[41])
          repo.technologies_fairicat = get_enum_for_technology_sheet_value(row[42])

          repo.other_technologies = row[43]
          repo.future_integrations = row[44]
          repo.anything_else = row[45]

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
