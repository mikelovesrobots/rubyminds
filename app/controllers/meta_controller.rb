class MetaController < ApplicationController
  layout 'default'

  def index
    @recent_articles = Article.last(5)
    @featured_article = @recent_articles.shift
    @recent_tweets    = Tweet.last(5)
    render :text => "ok", :layout => true
  end
end
