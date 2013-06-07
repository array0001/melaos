class AddDescripcionProductoToProduct < ActiveRecord::Migration
  def change
    add_column :products, :descripcion_producto, :text
  end
end
