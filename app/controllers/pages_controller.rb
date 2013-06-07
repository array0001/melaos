class PagesController < ApplicationController
  def home
  	@title = "Melaos"
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
