class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :category, null: false
      t.decimal :material_weight, precision: 10, scale: 2, null: false
      t.integer :production_time_seconds, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
