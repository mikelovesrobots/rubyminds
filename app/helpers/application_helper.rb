# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_tweet text, tweet_id
    link_to text, "#{AppConfig.twitter.home_url}/status/#{tweet_id}"
  end

  # Adds the class "current" to the link if the current page fits
  # the options for the link.  Otherwise delegates the call
  # to the regular link_to helper.
  #
  def link_to_with_current name, options = {}, html_options={}
    dup_options = html_options.dup
    
    if current_page?(options)
      dup_options[:class] = "current"
    end

    link_to name, options, dup_options
  end
end
