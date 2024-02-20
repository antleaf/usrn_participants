def read_csv_data(path)
  csv_data = nil
  begin
    csv_data = CSV.read(path, :headers => true, :encoding => 'UTF-8')
  rescue Exception => e
    raise
  end
  csv_data
end

def get_enum_form_of_sheet_value(value)
  value.gsub!(/[\s',]/, '_')
  value.gsub!(/__/, '_')
  value.downcase.to_sym
end

def get_enum_for_technology_sheet_value(value)
  enum_symbol = nil
  case value
  when 'I don’t know what it is'
    enum_symbol = :not_aware
  when 'We are considering this'
    enum_symbol = :considering
  when 'We are planning to implement this'
    enum_symbol = :planning_to_implement
  when 'We are actively working on implementing this'
    enum_symbol = :actively_implementing
  when 'We have already implemented this'
    enum_symbol = :already_implemented
  when 'We have decided not to implement this'
    enum_symbol = :rejected
  end
  enum_symbol
end


# def remove_selections_from_others(others,selections)
#   selections.each do |selection|
#     others.delete(selection)
#   end
#   others
# end