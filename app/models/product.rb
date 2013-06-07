# == Schema Information
#
# Table name: products
#
#  id                   :integer          not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  nombre_producto      :string(255)
#  descripcion_producto :text
#  imagen_producto_url  :string(255)
#  precio               :decimal(, )
#

class Product < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :nombre_producto, :descripcion_producto, :imagen_producto_url , :precio
  
  
  validates :nombre_producto, :presence =>true,
                   :length => { :maximum => 50 }
  
  validates :descripcion_producto, :presence   => true
                                   
  validates :precio, :presence => true,
                     :numericality => true,
                     :numericality => {:greater_than_or_equal_to => 100, :less_than => 500000}
                     
                  
  
  
  
end
