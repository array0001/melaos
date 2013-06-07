require 'spec_helper'

describe "LayoutLinks" do
    it "should have a Home page at '/'" do 
      get '/'
      response.should have_selector('title',:content=>'Melaos');
    end
    
    it "should have a Contact page at '/contacto'" do 
      get '/contacto'
      response.should have_selector('title',:content=>'Contacto');
    end
    
     it "should have a About page at '/about'" do 
      get '/about'
      response.should have_selector('title',:content=>'About');
    end
    
     it "should have a Help page at '/help'" do 
      get '/help'
      response.should have_selector('title',:content=>'Help');
    end
    
     it "should have a Registro page at '/registro'" do 
      get '/registro'
     response.should have_selector('title',:content=>'Registro');
    end
    
    it "should have a inicio sesion page at '/signin" do
      get '/signin'
      response.should have_selector('title', :content => "Iniciar Sesion")
    end
    
    it "should have links apropiados en el layout" do
      visit root_path
      response.should have_selector('title', :content => "Melaos")
      click_link "About"
      response.should have_selector('title', :content => "About")
      click_link "Contacto"
      response.should have_selector('title', :content => "Contacto")
      click_link "Melaos"
      response.should have_selector('title', :content => "Melaos")
      click_link "Registrese"
      response.should have_selector('title', :content => "Registro")
      response.should have_selector('a[href="/"]>img') #deberia tener una imagen
    end
    
    
    describe "Cuando no haya iniciado sesion" do
      it "should have un link de inicio de sesion" do
        visit root_path
        response.should have_selector("a", :href => signin_path,
                                          :content => "Iniciar sesion")
      end
    end
    
    describe "when signed in" do
      
      before(:each) do
       @user = FactoryGirl.create(:user)
       visit signin_path
       fill_in :email, :with => @user.email
       fill_in :password, :with => @user.password
       click_button  
      end
      
      
      it "should have un link al perfil" do
        visit root_path
        response.should have_selector("a", :href => user_path(@user),
                                           :content => "Perfil")
      end
      
      it "should have a settings link" do
        visit root_path
        response.should have_selector("a", :href => edit_user_path(@user),
                                           :content => "Ajustes")
      end
      
      
       it "should have a users link" do
        visit root_path
        response.should have_selector("a", :href => users_path,
                                           :content => "Usuarios")
      end
      
    end
end
