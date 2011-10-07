class SearchesController < ApplicationController

  def show
    @results = Search.perform(params[:q]) if params.include?(:q)
    render :action => "show"
  end

end
