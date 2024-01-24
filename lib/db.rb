require 'sequel'

DB = Sequel.connect(DB_CONNECTION_URL)

if RESET_DB then
  DB.drop_table? :output_types_repositories
  DB.drop_table? :repositories
  DB.drop_table? :platforms
  DB.drop_table? :output_types

end

DB.create_table? :output_types do
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
  String :notes, text: true
end

# joins
DB.create_table? :output_types_repositories do
  foreign_key :output_type_id, :output_types, :type => 'varchar'
  foreign_key :repository_id, :repositories
end