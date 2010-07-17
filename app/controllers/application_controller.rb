# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "logs"
  before_filter [:authorize,:set_current_user], :except => [:login, :contact, :email]

  helper :all # include all helpers, all the time
  helper_method :current_user
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  # include AuthenticatedSystem

  protected

  def current_user
    User.find(session[:user_id])
  end

  def set_current_user
    Authorization.current_user = User.find(session[:user_id])
  end

    def authorize
      unless User.find_by_id(session[:user_id])
        if session[:user_id] !=  nil # :logged_out
          authenticate_or_request_with_http_basic('hoanalog') do |username, password|
            user = User.authenticate(username, password)
            session[:user_id] = user.id if user
            end
        else
          flash[:notice] = "Please log in"
          redirect_to :controller => 'admin', :action => 'login'
        end
        # flash[:notice] = "Please log in"
        # redirect_to :controller => 'admin', :action => 'login'
      end
    end
end
