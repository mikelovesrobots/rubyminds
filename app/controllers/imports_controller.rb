class ImportsController < ApplicationController
  def all
    Tweet.import
    Article.import
    render :text => "ok", :layout => false
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
