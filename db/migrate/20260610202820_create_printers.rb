class CreatePrinters < ActiveRecord::Migration[8.0]
  def change
    create_table :printers do |t|
      t.string :printer_brand
      t.string :printer_model
      t.string :printer_name
      t.decimal :kilowatt_hour
      t.string :printer_ip
      t.string :serial
      t.string :access_code

      t.timestamps
    end
  end
end
