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



class User < ActiveRecord::Base
  attr_accessor :password #Virtual atribute for encrypted passwords
  attr_accessible :email, :nombre, :password, :password_confirmation, :created_at #crea Getter & Setters de todo lo que sea accesible desde el web
  #si se puede pasar el atributo como parte de un Hash TIENE que ser un atributo accesible.
  
  
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #Ver Rubular!
  
  validates :nombre, :presence =>true,
                     :length => { :maximum => 50 }
  
  validates :email, :presence => true,
                    :format   => { :with => email_regex},
                    :uniqueness => {:case_sensitive => false}
  
  validates :password, :presence     => true,
                       :confirmation => true, #con este parametro rails crea un atributo con <atributo>_confirmation
                       :length =>  { :within => 6..40 } #Range within a Hash
     
  #Register a callBack: method called in a particular time in the lifecycle of an object in this case is setting encryptPassword before saving the user.
  
  before_save :encrypt_password # as it'l be only use by an user then it should be a private method
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  #or can say class <<self <> end ; it is a class method cause at this point we dont even have user instance
  def User.authenticate(email, submitted_pass) #class method, also u can say self.authenticate(em,pass) and self is the CLASS itself
      user = User.find_by_email(email) #like an SQL but with magic
      return nil if user.nil? #if not user 
      return user if user.has_password?(submitted_pass)
  end
  
  def User.autenticar_con_sal(id,cookieconsal)
    user = find_by_id(id)
    (user && user.salt == cookieconsal) ? user : nil
  end
  
  private 
    def encrypt_password
      self.encrypted_password = encrypt(self.password) #encrypted_password belongs to the db
    end
    
    def encrypt(string)
      self.salt = make_salt if self.new_record? #self is the USER OBJECT! an instance
      secure_hash("#{self.salt}--#{string}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
end
