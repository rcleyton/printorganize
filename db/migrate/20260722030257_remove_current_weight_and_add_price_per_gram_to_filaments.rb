class RemoveCurrentWeightAndAddPricePerGramToFilaments < ActiveRecord::Migration[8.0]
  def change
    remove_column :filaments, :current_weight, :decimal
    add_column :filaments, :price_per_gram, :decimal, precision: 10, scale: 4
  end
end
