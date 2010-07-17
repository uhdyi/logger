class SearchController < ApplicationController
  filter_access_to :all

  def index
  end

  def show
    if params[:part_number].blank and params[:serial_number].blank and params[:user].blank
      @log = Log.find(:all, :order => :updated_at)
      
    end
  end

end
