class MetaController < ApplicationController
  layout 'default'

  def index
    recent_question_ids = $redis.lrange "Meta/most-recent-questions", 0, 4
    @recent_questions = recent_question_ids.present? ? Question[recent_question_ids] : []

    render :text => "ok", :layout => true
  end
end
