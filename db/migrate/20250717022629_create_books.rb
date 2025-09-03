class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.decimal :price
      t.string :condition
      t.string :category
      t.string :publisher
      t.string :isbn
      t.date :published_at
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
