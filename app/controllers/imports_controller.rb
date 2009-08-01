class ImportsController < ApplicationController
  def all
    Tweet.import
    Article.import
    redirect_to root_path
  end

  def twitter
    Tweet.import
    render :text => "ok", :layout => false
  end

  def delicious
    Article.import
    render :text => "ok", :layout => false
  end
end
