class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :stock
      t.decimal :price
      t.date :expiration_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
