# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  around_filter BenchmarkingFilter

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :set_default_meta_tags
  before_filter :load_last_tweet

  def set_default_meta_tags
    @keywords = []
    @description = ''
    @title = ''
  end

  def load_last_tweet
    @last_tweet = Tweet.last(1).first
  end
end
