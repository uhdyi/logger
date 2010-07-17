class LogsController < ApplicationController
  filter_access_to :all

  #def current_user
  #  User.find(session[:user_id])
  #end

  # GET /logs
  # GET /logs.xml
  def index
    # @logs = Log.paginate :page => params[:page], :per_page => 15
    x = Log.find(:all, :joins => "left join serials on serials.id=logs.serial_id", :order => "serials.serial_number ASC")
    @logs = x.paginate :page => params[:page], :per_page => 15

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @logs }
    end
  end

  # GET /logs/new
  # GET /logs/new.xml
  def new
    @log = Log.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @log }
    end
  end

  # GET /logs/1/edit
  def edit
    @log = Log.find(params[:id])

    @content = ""    
    @log.entries.each do|e|
        @content += "" # e.content
    end

  end

  # POST /logs
  # POST /logs.xml
  def create

    @entry = Entry.new(:content => '') #params[:content])
    @entry.location_id = params[:location][:id]
    @entry.user_id = session[:user_id]
    @entry.status_id = params[:status][:id]

    @log = Log.new(params[:log])
    @log.serial_id = Serial.find_by_serial_number(params[:serials][:serial_number]).id
    @log.entries << @entry
    
    respond_to do |format|
      if @log.save
        flash[:notice] = 'Log was successfully created.'
        format.html { redirect_to(@log) }
        format.xml  { render :xml => @log, :status => :created, :location => @log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /logs/1
  # PUT /logs/1.xml
  def update
    @log = Log.find(params[:id])
    @entry = Entry.new(:content => '')  #params[:log])
    @entry.user_id = session[:user_id]
    @entry.location_id = params[:location][:id]
    @entry.status_id = params[:status][:id]
    @log.entries << @entry

    respond_to do |format|
      if @log.save
        flash[:notice] = 'Log was successfully updated.'
        format.html { redirect_to(@log) }
        format.xml { head:ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @log.errors, :status => :unprocessabel_entity }
      end
    end
  end

  def profile
    respond_to do |format|
      format.html 
      format.xml  {}
    end
  end

  def get_content
    @category = params[:category]
    @html = ""

    if(@category == "Part Number")
      @products = Product.find(:all)

      # @products.each do |@product|
      @products.sort{|a, b| a.part_number <=> b.part_number}.each do|@product|
        @html += "<option value='#{@product.id}'>#{@product.part_number}</option>"
      end

    elsif (@category == "Serial Number")
      @serials = Serial.find(:all)

      # @html += "<option value="">Select Serial</option>"
      # @serials.each do |@serial|
      @serials.sort{|a, b| a.serial_number <=> b.serial_number}.each do |@serial|
         @html += "<option value='#{@serial.id}'>#{@serial.serial_number}</option>"
      end
      
    elsif (@category == "User Name")
      @users = User.find(:all)
    
      # @html += "<option value="">Select User</option>"
      # @users.each do |@user|
      @users.sort{|a, b| a.name <=> b.name}.each do |@user|
         @html += "<option value='#{@user.id}'>#{@user.name}</option>"
       end

    elsif (@category == "Location")
      @locations = Location.find(:all)

      # @html += "<option value="">Select Location</option>"
      # @locations.each do |@location|
      @locations.sort{|a, b| a.name <=> b.name}.each do |@location|
        @html += "<option value='#{@location.id}'>#{@location.name}</option>"
      end

    elsif (@category == "Status")
      @statuses = Status.find(:all)

      # @statuses.each do |@status|
      @statuses.sort{|a, b| a.name <=> b.name}.each do |@status|
        @html += "<option value='#{@status.id}'>#{@status.name}</option>"
      end

    else
      # 
    end

    render :update do |page|
      page.replace_html "content_options", @html
      end
  end

  # show the search result
  def basic_search
    @category = params[:category]
    @option = params[:content_options]
    @keywords = Array.new
    # @keywords << @option
    # @option = params[:option][:id]

    unless @category.blank? 
      @sql = ""

      if (@category == "Part Number")
   
        unless @option.empty?
          # @logs = Log.find_all_by_product_id(@option)
          @logs = Log.find(:all, :conditions => ["serials.product_id = ?", @option],
                           :joins => "LEFT JOIN serials on serials.id=logs.serial_id",
                           :group => "logs.id") 
          @keywords << Product.find(@option).part_number    
        else
          @logs = Log.find(:all)
        end
        
      elsif (@category == "Serial Number")
        
        unless @option.empty?
          @logs = Log.find_all_by_serial_id(@option)       
          @keywords << @option
        else
          @logs = Log.find(:all)
        end

      elsif (@category == "User Name")

        unless @option.empty?
          @logs = Log.find(:all, :conditions => ["entries.user_id = ?", @option],
                           :joins => "LEFT JOIN entries on entries.log_id=logs.id",
                           :group => "logs.id")
          # @logs = Log.find_all_by_user_id(@option)
          @keywords << User.find(@option).name
        else
          @logs = Log.find(:all)
        end

      elsif (@category == "Location")
        
        unless @option.empty?
          @logs = Log.find(:all, :conditions => ["entries.location_id = ?", @option],
                           :joins => "LEFT JOIN entries on entries.log_id=logs.id",
                           :group => "logs.id")
          # @logs = Log.find_all_by_location_id(@option)
          @keywords << Location.find(@option).name
        else
          @logs = Log.find(:all)
        end

      elsif (@category == "Status")

        unless @option.empty?
          @logs = Log.find(:all, :conditions => ["entries.status_id = ?", @option],
                           :joins => "LEFT JOIN entries on entries.log_id=logs.id",
                           :group => "logs.id")
          # @logs = Log.find_all_by_status_id(@option)
          @keywords << Status.find(@option).name
        else
          @logs = Log.find(:all)
        end

      else
          @logs = Log.find(:all) 
      end

    else
      @logs = Log.find(:all)
    end

    render :action => "show_advanced_search"

  end

  # show advanced search result
  def show_advanced_search
    @sql = ""
    @join = ""
    @part = params[:product][:id]
    @serial = params[:serial][:id]
    @user = params[:user][:id]
    @location = params[:location][:id] 
    @keywords = Array.new

    unless (@part.blank? and @serial.blank? and @user.blank? and @location.blank?)
      
      unless @serial.empty?
        @sql += "logs.serial_id=" + @serial
        @keywords << Serial.find(@serial).serial_number
      end

      unless @part.empty?
        @join = "LEFT JOIN serials ON serials.id=logs.serial_id" 

        unless @sql.empty?
          @sql += " AND serials.product_id=" + @part
        else 
          @sql += "serials.product_id=" + @part
        end
        @keywords << Product.find(@part).part_number
      end
      
      unless @user.empty?
        unless @sql.empty?
          @sql += " AND entries.user_id=" + @user
        else
          @sql += "entries.user_id=" + @user
        end
        @keywords << User.find(@user).name
      end

      unless @location.empty?
        unless @sql.empty?
          @sql += " AND entries.location_id=" + @location
        else
          @sql += "entries.location_id=" + @location
        end
        @keywords << Location.find(@location).name
      end

      unless @user.empty? and @location.empty? and @part.empty?
         @logs = Log.find(:all, :conditions => @sql,
                         :joins => (@join + " LEFT JOIN entries ON logs.id=entries.log_id"),
                         :group => "logs.id")
      else
         @logs = Log.find(:all, :conditions => @sql)

      end

    else
      @logs = Log.find(:all)
    end
    
    # render :update do |page|
    #  page.replace_html 'search_result',:partial => 'search_result', :object => @logs
    #end

    respond_to do |format|
      format.html 
      format.xml  {}
    end
  end

  def to_csv
    @logs = Log.find(:all)
    # @logs = Log.paginate :page => params[:page]
    
    @file = File.new("/home/dan/projects/hoanalog/logs.csv", "w+")
    @logs.each do |@log|
      @log_txt = Serial.find(@log.serial_id).serial_number + "," + Product.find(Serial.find(@log.serial_id).product_id).part_number + "," + Product.find(Serial.find(@log.serial_id).product_id).description.gsub(",", "-") + "," + Status.find(@log.latest_entry.status_id).name + "," +Location.find(@log.latest_entry.location_id).name
      @log_txt += "\n"
      @file.write(@log_txt)
    end
    @file.close

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @logs }
    end
  end

  def email_csv
    sub = 'log data'
    to = params[:receiver]
    sender = 'admin@hoana.com'
    email = LogMailer.create_sent_with_csv(sub, sender, to)
    LogMailer.deliver_sent_with_csv(sub, sender, to)    

    flash[:notice] = 'File is sent to ' + to + '.'
    redirect_to(:action => "to_csv")
  end

  # GET /logs/1
  # GET /logs/1.xml
  def show
    @log = Log.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @log }
    end
  end

  def auto_complete_for_serials_serial_number
    @serials = Serial.find :all, :order => 'serial_number ASC', :conditions => ['serial_number like ?',"#{params[:serials][:serial_number]}%"]
  end


end
