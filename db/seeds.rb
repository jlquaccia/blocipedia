require 'faker'

# Create users
25.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.free_email,
    password: Faker::Internet.password
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create wikis
50.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Name.title,
    body: Faker::Lorem.paragraph
  )
end

# Create an admin user
admin = User.new(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)
admin.skip_confirmation!
admin.save!

# Create a premium user
premium = User.new(
  name: 'Premium User',
  email: 'premium@example.com',
  password: 'helloworld',
  role: 'premium'
)
premium.skip_confirmation!
premium.save!

# Create standard user
standard = User.new(
  name: 'Standard User',
  email: 'standard@example.com',
  password: 'helloworld',
  role: 'standard'
)
standard.skip_confirmation!
standard.save!

puts "Seed finished."
puts "#{User.count} users created (Including 1 admin, 1 premium and 1 standard user)."
puts "#{Wiki.count} wikis created."