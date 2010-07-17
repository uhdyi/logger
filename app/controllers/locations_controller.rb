class LocationsController < ApplicationController
  filter_access_to :all

  def index
    @locations = Location.search(params[:search], params[:page])
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @locations }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /users/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        flash[:notice] = "Location #{@location.name} was successfully created."
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

 # PUT /users/1
  # PUT /users/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = "Location #{@location.name} was successfully updated."
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end


 # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end
end
