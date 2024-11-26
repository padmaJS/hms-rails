class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { guest: 0, admin: 1 }, default: :guest
  
  has_many :reviews
  has_many :bookings
  
  validates :name, :phone_number, :gender, presence: true
end
