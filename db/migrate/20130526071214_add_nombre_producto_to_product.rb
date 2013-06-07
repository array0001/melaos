class AddNombreProductoToProduct < ActiveRecord::Migration
  def change
    add_column :products, :nombre_producto, :string
  end
end
