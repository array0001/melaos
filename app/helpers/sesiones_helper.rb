module SesionesHelper
  def inicio_sesion(user)
    #usando cookies permanentes
    cookies.permanent.signed[:para_recordar] = [user.id,user.salt] 
    
    usuario_actual = user

  end
  
  def ha_iniciado_sesion?()
     return !usuario_actual.nil?
  end
  
  def usuario_actual?(user) #es el usuario que se manda igual al usuario logeado actualmente?
    user == usuario_actual
  end
  
  def sign_out
    cookies.delete(:para_recordar)
    usuario_actual = nil
    #self.usuario_actual = nil
  end
  
  def usuario_actual=(user)
    #setter method, accessor
    @usuario_actual = user
  end  
  
  def usuario_actual()
    @usuario_actual ||= usuario_recordado_contoken
    #28:24 -> sigin sccs @usuario_actual = @usuario_actual || user.find_by_id(1) evalua true
  end
  
   def negar_acceso
    guardar_ubicacion
    redirect_to signin_path, :notice => "Inicie sesion para acceder"
  end
  
 
  def ubicacion_cierre(ubicacion_path)
    session[:return_to] = ubicacion_path
  end
  
  def guardar_ubicacion
    session[:return_to] = request.fullpath #user/1/edit
    
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
  end
  
  private
    def usuario_recordado_contoken 
      User.autenticar_con_sal(*para_recordar)
      #*para_recordar , (*[1,2]) evalua como (1,2)
    end
    
  def para_recordar()
    cookies.signed[:para_recordar] || [nil,nil]
  end
  
  
  
end
