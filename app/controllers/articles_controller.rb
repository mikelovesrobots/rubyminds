class ArticlesController < ApplicationController
  def index
    @articles = Articles.last(10)
    respond_to do |format|
      format.html {}
      format.rss do
        render :action => :feed, :layout => false 
      end
    end
  end
end
