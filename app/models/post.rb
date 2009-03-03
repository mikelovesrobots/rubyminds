class Post < ActiveRecord::Base
  before_save :cache_body, :if => :body_changed?

  # Renders the markdown as html and caches it in the #html attribute.
  # On really massive posts, this can save 10 - 12 seconds per view
  # on production.
  def cache_body
    self.body_cache = BlueCloth.new(body).to_html
  end
end
