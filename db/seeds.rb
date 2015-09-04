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