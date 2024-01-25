require 'sequel'

DB = Sequel.connect(DB_CONNECTION_URL)

if RESET_DB then
  DB.drop_table? :depositors_repositories
  DB.drop_table? :consumers_repositories
  DB.drop_table? :output_types_repositories
  DB.drop_table? :repositories
  DB.drop_table? :platforms
  DB.drop_table? :output_types
  DB.drop_table? :depositors
  DB.drop_table? :consumers
end

DB.create_table? :output_types do
  String :id, :primary_key => true
  String :name
end

DB.create_table? :depositors do
  String :id, :primary_key => true
  String :name
end

DB.create_table? :consumers do
  String :id, :primary_key => true
  String :name
end

DB.create_table? :platforms do
  String :id, :primary_key => true
  String :name
  String :notes, text: true
end

DB.create_table? :repositories do
  Integer :id, :primary_key => true
  String :name
  String :url
  String :owner
  # TrueClass :publish,:default=>false
  foreign_key :platform_id, :platforms, :type => 'varchar'
  String :version
  String :role, text: true
  String :other_output_types
  String :other_depositors
  String :other_consumers
  String :disciplines, text: true
  String :policies, text: true
  Integer :mission_keeping_track
  Integer :mission_increase_discoverability
  Integer :mission_capture_metadata
  Integer :mission_avoid_duplication
  Integer :mission_populate_pids
  Integer :mission_timely_oa
  Integer :mission_machine_accessible
  String :nelson_awareness
  String :institutional_priority_challenges, text: true
  String :service_management, text: true
  String :software_management, text: true
  String :technical_expertise, text: true
  Integer :coar_framework_awareness
  String :management_challenges, text: true
  String :cris
  String :existing_integrations, text: true
  String :metadata_records
  String :content_items
  Integer :pid_minting
  String :technical_challenges, text: true
  Integer :innovation_appetite
  Integer :fair_awareness
  Integer :technologies_oai_pmh
  Integer :technologies_rioxx
  Integer :technologies_openaire_guidelines
  Integer :technologies_signposting
  Integer :technologies_resourcesync
  Integer :technologies_coar_notify
  Integer :technologies_coar_vocabularies
  Integer :technologies_jav
  Integer :technologies_credit
  Integer :technologies_counter
  Integer :technologies_fairicat
  String :other_technologies, text: true
  String :future_integrations, text: true
  String :anything_else, text: true

  String :notes, text: true
end

################# JOIN TABLES ##################################
DB.create_table? :output_types_repositories do
  foreign_key :output_type_id, :output_types, :type => 'varchar'
  foreign_key :repository_id, :repositories
end

DB.create_table? :depositors_repositories do
  foreign_key :depositor_id, :depositors, :type => 'varchar'
  foreign_key :repository_id, :repositories
end

DB.create_table? :consumers_repositories do
  foreign_key :consumer_id, :consumers, :type => 'varchar'
  foreign_key :repository_id, :repositories
end