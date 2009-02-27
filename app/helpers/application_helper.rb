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

  # Watches a given form element for changes and copies them to
  # the destination element.  Also accepts an optional frequency
  # denoting how often the field is checked for changes.
  # (default: 0.2 [seconds])
  #
  #   = form.text_field :title
  #   = live_field_preview :post_title, :preview_title
  #
  def live_field_preview(source_id, destination_id, frequency=0.2)
    %{
      <script type="text/javascript">
        new Form.Element.Observer(
          '#{source_id}',
          #{frequency},  // 200 milliseconds
          function(el, value){
            $('#{destination_id}').update(value)
          }
        )
      </script>
    }
  end
end
