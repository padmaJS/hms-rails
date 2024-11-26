class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :room_number
      t.integer :status, default: 0, null: false
      t.references :hotel, null: false, foreign_key: true
      t.string :timestamps
      t.decimal :price, null: false, default: 0

      t.timestamps
    end
  end
end
