# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # displays flash messages by type of message
  def display_flash_message
    flash_types, string = [ :error, :warning, :notice ], ''
    flash_types.each { |ft| string << "<div class=\"flash #{ft.to_s}\">#{flash[ft]}</div>" unless flash[ft].nil? }
    string
  end
end
