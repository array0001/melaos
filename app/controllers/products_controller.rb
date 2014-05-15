class ProductsController < ApplicationController
  before_filter :admin_user, :only => [:destroy,:edit,:new]
  
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @title = "Productos"
    redirect_to  '/maintenance.html'
    # Descomentar para volver a mostrar pagina de Productos
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @products }
    #end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
    
  end

  # GET /products/1/edit
  def edit
    @title = "Editar producto"
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

   
      if @product.save
        flash[:success] = "Producto creado"
        redirect_to products_path
      else
    
        flash[:error] = "Producto no creado"
        @title = "Crear producto"
        render 'new'
      end
   
  end
  
  
    


  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])
      if @product.update_attributes(params[:product])
         redirect_to products_path
        flash[:success] = "Cambios Guardados"
      else
         @title = "Editar producto"
         render 'edit'
      end
    end
  

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "Producto Eliminado."
    redirect_to products_path
   
  end
  
  
  private 
 
    def admin_user
      redirect_to(root_path) unless usuario_actual.admin?
    end
  

  
end
