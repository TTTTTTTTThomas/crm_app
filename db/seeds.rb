# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.find_or_create_by(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end if Rails.env.development?

# Create sample customers
Customer.create!([
  {
    full_name: "John Smith",
    phone_number: "(555) 123-4567",
    email_address: "john.smith@email.com",
    notes: "Regular customer, prefers phone contact."
  },
  {
    full_name: "Sarah Johnson",
    phone_number: "(555) 987-6543",
    email_address: "",
    notes: "New customer, interested in premium services."
  },
  {
    full_name: "Michael Brown",
    phone_number: "(555) 456-7890",
    email_address: "m.brown@company.com",
    notes: "Corporate client, handles multiple accounts."
  },
  {
    full_name: "Emily Davis",
    phone_number: "(555) 321-0987",
    email_address: "",
    notes: "Prefers text messages over email."
  },
  {
    full_name: "Robert Wilson",
    phone_number: "(555) 654-3210",
    email_address: "robert.wilson@gmail.com",
    notes: "Long-time customer, very satisfied with service."
  },
  {
    full_name: "Lisa Anderson",
    phone_number: "(555) 789-0123",
    email_address: "",
    notes: "Potential high-value customer."
  }
])