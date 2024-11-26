class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :profile_image, :string
    add_column :users, :gender, :string
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :confirmed_at, :datetime
  end
end
