class AddBrandToFilaments < ActiveRecord::Migration[8.0]
  def change
    add_column :filaments, :brand, :string, null: false, default: ""
  end
end
