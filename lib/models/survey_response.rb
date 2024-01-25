# frozen_string_literal: true

class SurveyResponse < Sequel::Model
  plugin :enum
  set_primary_key :id
  unrestrict_primary_key
  many_to_one :repository
  many_to_many :output_types, join_table: :output_types_survey_responses
  many_to_many :depositors, join_table: :depositors_survey_responses
  many_to_many :consumers, join_table: :consumers_survey_responses

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
        sr = SurveyResponse.create

        sr.repository = Repository[row['Repository ID']]

        sr.timestamp = Time.parse(row[1])

        sr.role = row[4]
        sr.other_output_types = row[5]

        choices = OutputType.map { |x| x.name }
        choices.each do |choice|
          if sr.other_output_types.include?(choice)
            sr.add_output_type(OutputType.first(name: choice))
          end
        end

        sr.disciplines = row[6]

        sr.other_depositors = row[7]
        choices = Depositor.map { |x| x.name }
        choices.each do |choice|
          if sr.other_depositors.include?(choice)
            sr.add_depositor(Depositor.first(name: choice))
          end
        end

        sr.other_consumers = row[8]
        choices = Consumer.map { |x| x.name }
        choices.each do |choice|
          if sr.other_consumers.include?(choice)
            sr.add_consumer(Consumer.first(name: choice))
          end
        end

        sr.policies = row[9]

        sr.mission_keeping_track = get_enum_form_of_sheet_value(row[10])
        sr.mission_increase_discoverability = get_enum_form_of_sheet_value(row[11])
        sr.mission_capture_metadata = get_enum_form_of_sheet_value(row[12])
        sr.mission_avoid_duplication = get_enum_form_of_sheet_value(row[13])
        sr.mission_populate_pids = get_enum_form_of_sheet_value(row[14])
        sr.mission_timely_oa = get_enum_form_of_sheet_value(row[15])
        sr.mission_machine_accessible = get_enum_form_of_sheet_value(row[16])

        sr.nelson_awareness = row[17]
        sr.institutional_priority_challenges = row[18]
        sr.service_management = row[19]
        sr.software_management = row[20]
        sr.technical_expertise = row[21]

        sr.coar_framework_awareness = get_enum_form_of_sheet_value(row[22])

        sr.management_challenges = row[23]
        sr.cris = row[24]
        sr.existing_integrations = row[25]
        sr.metadata_records = row[26]
        sr.content_items = row[27]
        sr.pid_minting = get_enum_form_of_sheet_value(row[28])
        sr.technical_challenges = row[29]
        sr.innovation_appetite = row[30]

        case row[31]
        when 'Not aware of FAIR'
          sr.fair_awareness = :not_aware
        when 'Vaguely aware of FAIR'
          sr.fair_awareness = :vaguely_aware
        when 'Considering how to adopt the FAIR principles'
          sr.fair_awareness = :considering
        when 'Actively working to adopt FAIR principles'
          sr.fair_awareness = :actively_working
        when 'Do not think FAIR is relevant/useful'
          sr.fair_awareness = :not_relevant
        end

        sr.technologies_oai_pmh = get_enum_for_technology_sheet_value(row[32])
        sr.technologies_rioxx = get_enum_for_technology_sheet_value(row[33])
        sr.technologies_openaire_guidelines = get_enum_for_technology_sheet_value(row[34])
        sr.technologies_signposting = get_enum_for_technology_sheet_value(row[35])
        sr.technologies_resourcesync = get_enum_for_technology_sheet_value(row[36])
        sr.technologies_coar_notify = get_enum_for_technology_sheet_value(row[37])
        sr.technologies_coar_vocabularies = get_enum_for_technology_sheet_value(row[38])
        sr.technologies_jav = get_enum_for_technology_sheet_value(row[39])
        sr.technologies_credit = get_enum_for_technology_sheet_value(row[40])
        sr.technologies_counter = get_enum_for_technology_sheet_value(row[41])
        sr.technologies_fairicat = get_enum_for_technology_sheet_value(row[42])

        sr.other_technologies = row[43]
        sr.future_integrations = row[44]
        sr.anything_else = row[45]

        sr.save
      end
      LOG.info("Loaded repository data from #{path}")
    rescue Exception => e
      LOG.error(e)
    end
  end
end
