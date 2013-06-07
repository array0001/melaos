require 'spec_helper'

describe SesionesController do
  render_views #porq tenemos have_selector Tag

    describe "GET 'new'" do
      
    
      it "returns http success" do
        get 'new'
        response.should be_success
      end
  
    
      it "Deberia tener titulo correcto" do
        get 'new'
        response.should have_selector('title', :content => "Iniciar Sesion")
      
      end
      
   
   end
   
   #en la creacion deberia: en caso de
   #Fallo:
   
   #renderizar la nueva pagina 'new'
   
   describe "DELETE 'destroy" do 
     it "Deberia cerrar sesion " do
       test_cerrar_sesion(FactoryGirl.create(:user))
       delete :destroy
       controller.should_not be_ha_iniciado_sesion
       response.should redirect_to(root_path)
     end
   end


end
