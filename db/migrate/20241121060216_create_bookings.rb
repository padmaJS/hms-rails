class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.integer :total_amount
      t.date :checkin_day
      t.date :checkout_day
      t.integer :status, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.string :timestamps

      t.timestamps
    end
  end
end
