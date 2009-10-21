class ArchivesController < ApplicationController
  layout 'default'

  def index
    @page = (params[:page].to_i > 0 ? params[:page].to_i : 1)

    @articles = Article.paginate(@page, 10)
    respond_to do |format|
      format.html {}
      format.rss do
        render :action => :feed, :layout => false 
      end
    end
  end
end

