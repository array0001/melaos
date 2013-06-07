# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  nombre             :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

  require 'spec_helper'

  describe User do
     
     before(:each) do
       @attr = {
          :nombre   => "UsuarioEjemplo", 
          :email    => "Usario@ejemplo.com", 
          :password => "contrasenaprueba",
          :password_confirmation => "contrasenaprueba"
               }
     end
     
     before(:each) do
      @user = User.new(@attr)
    end

      
     # Validaciones creacion de usuario nombre ------------------------------------
     it "should create a new instance given a valid attribute" do 
       User.create!(@attr)
     end
     
     #validaciones creacion de usuario con email ----------------------------------
     
     
     #validaciones creacion usuario para la contrasena ----------------------------
     
    describe "passwords" do
      
      it "should have a password attribute" do 
        User.new(:nombre => "asd", :email => "kkd").should respond_to(:password)
      end
   
    
      it "should have a password confirmation attribute" do 
        @user.should respond_to(:password_confirmation)
     end
    
   end
#   
#       validaciones de contrasena
#   
   describe "password validations" do
     it "should require a password" do 
        User.new(@attr.merge(:password => "", :password_confirmation => "" )).
        should_not be_valid  
     end #--> este test pasa porque tenemos en el user.rb que el password necesita estar presente.
#
     it "Should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")). #pasa porque la contrasena de @attr:contrasenaprueba no es match con invalid
              should_not be_valid
     end
     
     it "Should reject short passwords" do
      short = "a"*5 # passwords between 5 y <40>
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid  
     end
     
     it "Should reject long passwords" do
         long = "a"*41
         hash = @attr.merge(:password => long, :password_confirmation => long)
         User.new(hash).should_not be_valid  
     end
     
   end
   
   describe "password encryption" do 
     
     before(:each) do 
       @user = User.create!(@attr)
     end
     
     it "should have an encrypted password attribute" do 
       @user.should respond_to(:encrypted_password)
     end
     
     it "should set the encrypted password attribute" do
        @user.encrypted_password.should_not be_blank
     end
     
     
     it "should have a salt" do
       @user.should respond_to(:salt)
     end
     
 
   describe "has_password? method" do
     it "should exist" do
       @user.should respond_to(:has_password?)
     end
     
    it "should return true if passwords match " do
      @user.has_password?(@attr[:password]).should be_true
    end
    
    it "should return false if pwd dont match" do
         @user.has_password?("invalido").should be_false
    end   
   end
   
   describe "authenticate method" do
     it "should return nil on email-password mismatch" do
       User.authenticate(@attr[:email],"wrongOne").should be_nil
     end
     
     it "should exist" do
       User.should respond_to(:authenticate)
     end
     
     it "should return nil for an email addres with no user" do
       User.authenticate("asd@afff.com", @attr[:password]).should be_nil
     end
     
     it "should return user on email/password on match" do
       User.authenticate(@attr[:email],@attr[:password]).should == @user
     end
     
   end
  end 
end
