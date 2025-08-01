# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Sample User data
users_data = [
  { name: "John Doe", email: "john.doe@example.com" },
  { name: "Jane Smith", email: "jane.smith@example.com" },
  { name: "Bob Johnson", email: "bob.johnson@example.com" },
  { name: "Alice Brown", email: "alice.brown@example.com" },
  { name: "Charlie Wilson", email: "charlie.wilson@example.com" },
  { name: "Diana Davis", email: "diana.davis@example.com" },
  { name: "Edward Miller", email: "edward.miller@example.com" },
  { name: "Fiona Garcia", email: "fiona.garcia@example.com" },
  { name: "George Martinez", email: "george.martinez@example.com" },
  { name: "Helen Taylor", email: "helen.taylor@example.com" }
]

users_data.each do |user_attrs|
  User.find_or_create_by!(email: user_attrs[:email]) do |user|
    user.name = user_attrs[:name]
  end
end

puts "Created #{User.count} users"
