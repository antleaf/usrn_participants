require 'sequel'

DB = Sequel.connect(DB_CONNECTION_URL)

if RESET_DB then
  DB.drop_table? :repositories
  DB.drop_table? :platforms
end

DB.create_table? :platforms do
  String :id, :primary_key => true
  String :name
  String :notes, text: true
end

DB.create_table? :repositories do
  String :id, :primary_key => true
  String :name
  String :url
  String :owner
  # TrueClass :publish,:default=>false
  foreign_key :platform_id, :platforms, :type => 'varchar'
  String :version
  String :notes, text: true
end

