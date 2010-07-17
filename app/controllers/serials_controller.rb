class SerialsController < ApplicationController
  filter_access_to :all

  # GET /serials
  # GET /serials.xml
  def index
    @serials = Serial.search(params[:search], params[:page])
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @serials }
    end
  end

  # GET /serials/1
  # GET /serials/1.xml
  def show
    @serial = Serial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @serial }
    end
  end

  # GET /serials/new
  # GET /serials/new.xml
  def new
    @serial = Serial.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @serial }
    end
  end

  # GET /serials/1/edit
  def edit
    @serial = Serial.find(params[:id])
  end

  # POST /serials
  # POST /serials.xml
  def create
    @serial = Serial.new(params[:serial])
    @serial.product_id = params[:product][:id]

    respond_to do |format|
      if @serial.save
        flash[:notice] = 'Serial was successfully created.'
        format.html { redirect_to(@serial) }
        format.xml  { render :xml => @serial, :status => :created, :location => @serial }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @serial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /serials/1
  # PUT /serials/1.xml
  def update
    @serial = Serial.find(params[:id])
    @serial.product_id = params[:product][:id]

    respond_to do |format|
      if @serial.update_attributes(params[:serial])
        flash[:notice] = 'Serial was successfully updated.'
        format.html { redirect_to(@serial) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @serial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /serials/1
  # DELETE /serials/1.xml
  def destroy
    @serial = Serial.find(params[:id])
    @serial.destroy

    respond_to do |format|
      format.html { redirect_to(serials_url) }
      format.xml  { head :ok }
    end
  end

end
