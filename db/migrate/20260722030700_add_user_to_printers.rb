class AddUserToPrinters < ActiveRecord::Migration[8.0]
  def change
    add_reference :printers, :user, foreign_key: true, null: true
  end
end
