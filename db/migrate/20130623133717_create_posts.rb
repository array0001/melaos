class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.string :image

      t.timestamps
    end
    add_index :posts, :created_at
  end
end
