class ArchivesController < ApplicationController
  layout 'default'

  def index
    @articles = Article.last(20)
    respond_to do |format|
      format.html {}
      format.rss do
        render :action => :feed, :layout => false 
      end
    end
  end
end

