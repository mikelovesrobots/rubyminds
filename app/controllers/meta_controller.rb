class MetaController < ApplicationController
  layout 'default'

  def index
    @recent_questions = Question.last(4)
    @recent_tweets    = Tweet.last(5)
    render :text => "ok", :layout => true
  end
end
