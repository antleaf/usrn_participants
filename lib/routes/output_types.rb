# frozen_string_literal: true

get '/output-types' do
  @output_types = OutputType.all
  @page_title = "All Output Types"
  haml :output_types, :layout => :'layout'
end

get '/output-types/:id' do
  @output_type = OutputType[params[:id]]
  @repositories = @output_type.survey_responses.map { |r| r.repository }
  @page_title = "Output type: #{@output_type.name}"
  haml :output_type, :layout => :'layout'
end