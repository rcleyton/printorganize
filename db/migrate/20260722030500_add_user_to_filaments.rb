class AddUserToFilaments < ActiveRecord::Migration[8.0]
  def change
    # Adding user reference, allowing null initially for backfill.
    add_reference :filaments, :user, foreign_key: true, null: true
  end
end
