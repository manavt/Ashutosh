class RemoveColumnsFromImage < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :user_id
    remove_column :images, :product_id
  end
end
