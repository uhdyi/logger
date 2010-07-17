class AdminController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        # self.current_user = user
        redirect_to(:controller => "logs", :action => "index")
      else 
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil # :logged_out
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

  def index
  end

  def contact
    respond_to do |format|
      format.html # contact.html.erb
      format.xml  { render :xml => @logs }
    end
  end

end
