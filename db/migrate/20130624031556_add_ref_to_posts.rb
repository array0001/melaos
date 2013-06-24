class AddRefToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ref, :string
  end
end
