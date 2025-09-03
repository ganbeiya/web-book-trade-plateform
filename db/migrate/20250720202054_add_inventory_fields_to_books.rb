class AddInventoryFieldsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :stock, :integer, default: 0, null: false

    add_reference :books, :category, index: true
  end
end
