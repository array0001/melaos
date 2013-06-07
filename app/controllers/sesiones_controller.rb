class SesionesController < ApplicationController
  def new
    @title = "Iniciar Sesion" #esta implicito en el new
  end
  
  def create
    user = User.authenticate(params[:sesion][:email],
                             params[:sesion][:password] )
    if user.nil?
      flash.now[:error] = "Email o contrasena invalidos"
      @title = "Iniciar Sesion"
      render 'new' 
    else
      #inicion de sesion exitoso
      inicio_sesion user
      redirect_back_or(user)
    end
    
    
  end
  
  def destroy
    sign_out
    ubicacion_cierre(@user)
    redirect_to root_path
  end
  
end
