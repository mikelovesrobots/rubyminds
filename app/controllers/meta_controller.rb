class MetaController < ApplicationController
  layout 'default'

  def index
    @recent_articles = Article.last(5)
    @featured_article = @recent_articles.shift
    @recent_tweets    = Tweet.last(5)
    @keywords = @recent_articles.collect { |x| Array(x.tags) }.flatten
  end

  def about
  end
end
