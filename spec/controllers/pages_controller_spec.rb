require 'spec_helper'

describe PagesController do 
 render_views
    
  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

    it  "should have the right title" do 
      get 'home'
    response.should have_selector("title",:content => "Melaos")
    end
    
 end

  describe "GET 'contacto'" do
    it "returns http success" do
      get 'contacto'
      response.should be_success
    end
    
      it  "should have the right title" do 
      get 'contacto'
    response.should have_selector("title",:content => "Contacto")
    end
  end

    describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
      it  "should have the right title" do 
        get 'about'
    response.should have_selector("title",:content => "About")
    end 
  end
  
  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
      it  "should have the right title" do 
        get 'help'
    response.should have_selector("title",:content => "Help")
    end    
  end

end
