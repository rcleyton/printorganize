class CreateFilaments < ActiveRecord::Migration[8.0]
  def change
    create_table :filaments do |t|
      t.string  :name,           null: false
      t.integer :material_type,  null: false
      t.string  :color,          null: false
      t.decimal :initial_weight, null: false, precision: 10, scale: 2
      t.decimal :current_weight, null: false, precision: 10, scale: 2
      t.decimal :purchase_price, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
