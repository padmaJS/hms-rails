class CreateHotels < ActiveRecord::Migration[8.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.time :checkin_time
      t.time :checkout_time
      t.string :email
      t.string :phone_number
      t.string :instagram_url
      t.string :facebook_url
      t.string :timestamps

      t.timestamps
    end
  end
end
