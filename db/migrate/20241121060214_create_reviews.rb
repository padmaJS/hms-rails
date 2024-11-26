class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.string :timestamps

      t.timestamps
    end
  end
end
