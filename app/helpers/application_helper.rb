# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Renders the given markdown-format text as html
  #
  #   render_markdown("*test*")
  #   # => "<em>test</em>"
  #
  def render_markdown(text)
    BlueCloth.new(text).to_html
  end
end
