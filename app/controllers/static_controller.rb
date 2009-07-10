class StaticController < ApplicationController
  layout 'default'

  def index
    recent_question_ids = $redis.lrange "Meta/most-recent-questions", 0, 4
    @recent_questions = $redis.mget(*recent_question_ids) if recent_question_ids.present?

    render :text => "ok", :layout => true
  end
end
