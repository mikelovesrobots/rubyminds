# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_tweet text, tweet_id
    link_to text, "http://twitter.com/mikelovesrobots/status/#{tweet_id}"
  end
end
