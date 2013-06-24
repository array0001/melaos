class PagesController < ApplicationController
  def home
  	@title = "Melaos"
  	@post = Post.all
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
