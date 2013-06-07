class AddImagenProductoToProduct < ActiveRecord::Migration
  def change
    add_column :products, :imagen_producto_url, :string
  end
end
