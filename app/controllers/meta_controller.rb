class MetaController < ApplicationController
  layout 'default'

  def index
    @recent_questions = Question.last(4)

    render :text => "ok", :layout => true
  end
end
