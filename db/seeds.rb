# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding countries..."
load Rails.root.join("db/seeds/countries.rb")

puts "Seeding regions..."
load Rails.root.join("db/seeds/regions.rb")

puts "Seeding cities..."
load Rails.root.join("db/seeds/cities.rb")

puts "Seeding vehicle makes..."
load Rails.root.join("db/seeds/vehicle_makes.rb")

puts "Seeding vehicle models..."
load Rails.root.join("db/seeds/vehicle_models.rb")

puts "Seeding colors..."
load Rails.root.join("db/seeds/colors.rb")

puts "Seeding Service Categories..."
load Rails.root.join("db/seeds/service_categories.rb")

admin = Admin.find_or_initialize_by(email: "super_admin@example.com")

admin.name = "Admin"
admin.password = "password"
admin.password_confirmation = "password"
admin.locale = "ar"
admin.type = "Admin"
admin.deleted_at = nil

admin.save!

puts "Admin created: #{admin.email}"

puts "Seeding completed."
