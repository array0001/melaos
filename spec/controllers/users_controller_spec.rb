require 'spec_helper'


describe UsersController do
    render_views
    
    describe "GET 'index'" do
      
      describe "para usuarios que no han iniciado sesion" do
        
        it " deberia negar el acceso a usuarios que no han iniciado sesion " do
           get :index
           response.should redirect_to(signin_path)
        end
      end
        
        describe "para usuarios que si han iniciado sesion " do
          before(:each) do
            @user = test_inicio_sesion(FactoryGirl.create(:user))
            FactoryGirl.create(:user, :email => "otroEmail@ejemplo1.com")
            FactoryGirl.create(:user, :email => "otroEmail@ejemplo2.com")
            FactoryGirl.create(:user, :email => "otroEmail@ejemplo3.com")
          end
          
          it " deberia redirigir a index - be succesfull" do
            get :index
            response.should be_success  
          end
          
          
          it "should tener el titulo correcto" do
            get :index
            response.should have_selector('title' , :content  => "USUARIOS")
          end
          #response.should redirect_to(index_path)
          
          it "debe haber un elemento por usuario" do
            get :index
            User.all.each do |user|
              response.should have_selector('li', :content => user.nombre)
            end
          end
          
        end
        
        
  
      
    end
    
    
    describe  "GET 'show'" do
      
      before(:each) do
        @user = FactoryGirl.create(:user) #utiliza la gema factory girl para no tener que crear un usuario en cada test
      end
      
      it "should be succesfull" do
       get :show, :id => @user
        response.should be_success
      end
      
      it "should find the right user when requested" do
        get :show,:id => @user
        assigns(:user).should == @user # assigns reaches into the users controller(context of the test) 
        # and assigns 7:conclusion 9:00
      end
        
      it "should have the right title" do
        get :show,:id =>@user
        response.should have_selector('title',:content => @user.nombre )
      end
      
      it "should have the user name" do 
        get :show,:id => @user
        response.should have_selector('h2', :content => @user.nombre)
      end
      
      it "should have an image" do
        get :show, :id => @user
        response.should have_selector('h2>img',:class => "gravatar")
      end
      
    end


  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

  
  it "Deberia tener titulo correcto" do
      get 'new'
      response.should have_selector('title', :content => "Registro")
    end
  end
  
  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:nombre =>"", :email => "", :password => "",:password_confirmation => ""}
      end
      
      it "Deberia tener el titutlo correcto" do
        post :create, :user => @attr
        response.should have_selector('title', :content =>"Registro")
      end
      
      it "Deberia renderizar la pagina 'new'" do
        post :create, :user => @attr
        response.should render_template('new')
      end
      
      it "No deberia crear usuario" do
        #Usando lamda-block?
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count) #change metodo de rspec y llama al metodo correspondiente al simbolo en el primer argumento User en este caso
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = {:nombre => "NuevoUsuario", :email => "user@edx.com", :password => "asdContrasenaLarga",:password_confirmation => "asdContrasenaLarga"}        
      end
      
      it "should create a user" do
            lambda do
              post :create, :user => @attr
            end.should change(User,:count).by(1)
      end
      
      it "should redirect to user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user))) #assigns saca el @user de la definicion de create
      end
      
      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /Bienvenido a Melaos/i
      end
      
      it "should sign out the user" do
        post :create, :user => @attr
        controller.should be_ha_iniciado_sesion
      end
    
    end
  end
  
  
  describe "GET 'edit'" do
    before(:each) do
      @user =FactoryGirl.create(:user)
      test_inicio_sesion(@user)
    end
  
    it "should be succesfull" do
      get :edit, :id => @user 
      response.should be_success
    end
    
    it "should have right title" do
      get :edit, :id => @user
      response.should have_selector('title', :content => "Editar Usuario")
    end
    
    it "should  have link para cambiar la imagen del gravatar" do
      get :edit, :id => @user
      response.should have_selector('a', :href => 'http://gravatar.com/emails',    
                                        :content => "Cambiar Gravatar" )
    end
    
    
  end
  
  describe "PUT 'update" do
    
    before(:each) do
        @user = FactoryGirl.create(:user)
        test_inicio_sesion(@user)
      end
    
    describe "failure" do
      
      before(:each) do
        @attr = {:nombre => "", :email => "", :password => "", :password_confirmation => ""}
        
      end
      
      it "should render the edit page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector('title', :content => "Editar Usuario")
      end
      
    end
    
    describe "succes" do
      
      before(:each) do
        @attr = {:nombre => "New Name", :email => "User@example.com",
                 :password => "contrasena", :password_confirmation => "contrasena"}   
      end
      
      it "should cambiar los atributos de usuario" do
        put :update, :id => @user, :user => @attr
        user = assigns(:user)
        @user.reload
        @user.nombre.should == user.nombre
        @user.email.should == user.email
        @user.encrypted_password.should == user.encrypted_password
      end
      
    end
    
  end
  
  
  
  describe "Authenticacion de edicion o actualizacion" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    describe "Para usuarios que no han iniciado sesion" do
        it "should negar acceso a 'editar'" do # NO HA INICIADO SESION
          get :edit, :id => @user 
          response.should redirect_to(signin_path)
          flash[:notice].should =~ /Inicie Sesion/i
        end
        
        
        it "should negar acceso a 'update" do
          put :update, :id => @user, :user => {}
          response.should redirect_to(signin_path)
          
        end
    end
    
    describe "Para usuarios que han iniciado sesion" do
      before(:each) do
        usuario_incorrecto = FactoryGirl.create(:user, :email => "usuario@ejemplo.com")
        test_inicio_sesion(usuario_incorrecto)
      end
      
      it "should requerir que el usuario sea el que se esta editando 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      
      it "should requerir que el usuario sea el que se esta actualizando 'update'" do
        put :update, :id => @user, :user => {}
        #Medio enredado: el usuario incorrecto definido en el before es el que esta logeado, se compara con el @user que es el de mas arriba
        #lssn protecting pages ->
        response.should redirect_to(root_path)
      end
    end

  end
  
end