class StaticController < ApplicationController
  layout 'default'

  def index
    render :text => "ok", :layout => true
  end
end
