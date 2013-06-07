class UsersController < ApplicationController

before_filter :authenticate, :only => [:index, :edit , :update, :destroy] #5:00 l-10 Protecting pages

before_filter :correct_user, :only => [:edit, :update]

before_filter :admin_user, :only => :destroy
#REST acciones Show , new , create, edit , update, index and destroy
 
 def index
   @title = "USUARIOS"
   @users = User.all
 end
 
  def new
    @user = User.new #just declaring, no instancia porq en el formulario es donde se instancia
    @title = "Registro"
  end
  
  def show
    @user = User.find(params[:id]) #params tiene que ver con lo que se obtiene al llamar a get show, mirar routes y mirar el test para un ejemplo
    @title = @user.nombre
  end
  
  def create
    
    if  ha_iniciado_sesion?
      flash[:notice] = "Usted ya ha iniciado sesion"
      return redirect_to root_path
    end
    
    @user = User.new(params[:user])
        
    if @user.save
      inicio_sesion @user
      flash[:success] ="Bienvenido a Melaos"
      redirect_to user_path(@user)
      
    else
      @title = "Registro"
      render 'new'
    end
   
  end


  def edit
    @user = User.find(params[:id])
    @title = "Editar Usuario"
  end
  
  def update
    @title = "Editar Usuario"
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
      flash[:success] = "Cambios Guardados"
    else
      @title = "Editar Usuario"
       render 'edit'
    end
   
    
    #if(@user.save)
    #  inicio_sesion @user
    #  flash[:succes] = "Cambios Guardados"
    #  redirect_to user_path(@user)
    #end
    
  end
  
  def destroy
    #27:32 Destroying users
    User.find(params[:id]).destroy
    flash[:success] = "Usuario Eliminado."
    redirect_to users_url
  end

  
  private 
      def authenticate
        negar_acceso unless ha_iniciado_sesion?
      end
      
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless usuario_actual?(@user)
      end
  
      def admin_user
        user = User.find(params[:id])
        redirect_to(root_path) unless (usuario_actual.admin? && !usuario_actual?(@user))
      end
  
end
