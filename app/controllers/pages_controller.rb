class PagesController < ApplicationController
  def home
  	@title = "Melaos"
  	@post = Post.all
  	@npost = Post.new if ha_iniciado_sesion?
  end

  def contacto
  	@title = "Contacto"
  end

  def about
  	@title = "About"
  end
  
  def help
      @title = "Help"
  end
  
  
end
