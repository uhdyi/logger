class ProductsController < ApplicationController
  filter_access_to :all

  def index
    unless params[:search].nil?
      @products = Product.search(params[:search][:id], params[:page])
    else
      @products = Product.search(nil, params[:page])
    end
                                 
    respond_to do |format|
      format.html
      format.xml { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /users/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = "Product #{@product.part_number} was successfully created."
        format.html { redirect_to(:action=>'index') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

 # PUT /users/1
  # PUT /users/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = "Product #{@product.part_number} was successfully updated."
        format.html { redirect_to(:action=>'index') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
end
