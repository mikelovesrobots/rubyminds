class MetaController < ApplicationController
  layout 'default'

  def index
    @recent_questions = Question.last(4)
    @featured_question = @recent_questions.shift
    @recent_tweets    = Tweet.last(5)
    render :text => "ok", :layout => true
  end
end
