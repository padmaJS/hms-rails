admin = User.create!(
  email: 'admin@admin.com',
  password: 'asdfasdf',
  password_confirmation: 'asdfasdf',
  role: :admin,
  confirmed_at: Time.now,
  phone_number: "1234567890",
  gender: "male",
  name: "admin"
)

guest = User.create!(
  email: 'guest@hms.com',
  password: 'password',
  password_confirmation: 'password',
  role: :guest,
  confirmed_at: Time.now,
  phone_number: "1234567890",
  gender: "male",
  name: "guest"
)

hotel = Hotel.create!(
  name: 'Hotel Heritage Bajracharya',
  address: 'Nasamana 3 Bhaktapur',
  checkin_time: '14:00',
  checkout_time: '12:00',
  email: 'contact@hotelheritage.com',
  phone_number: '+1234567890',
  instagram_url: 'https://instagram.com/hotelheritage',
  facebook_url: 'https://facebook.com/hotelheritage'
)

[
  { room_number: "101", price: 100 },
  { room_number: "102", price: 120 },
  { room_number: "103", price: 150 },
  { room_number: "201", price: 200 },
  { room_number: "202", price: 220 },
  { room_number: "203", price: 250 }
].each do |room|
  Room.create!(
    hotel: hotel,
    room_number: room[:room_number],
    price: room[:price],
    status: :available
  )
end

Booking.create!(
  user: guest,
  hotel: hotel,
  checkin_day: Date.today + 1,
  checkout_day: Date.today + 5,
  total_amount: 400,
  status: :confirmed,
  rooms: [Room.first]
)

