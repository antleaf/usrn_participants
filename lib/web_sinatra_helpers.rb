# frozen_string_literal: true

helpers do
  def process_text(text)
    text.gsub(/(\r\n|\n|\r)/, '<br />')
  end
end