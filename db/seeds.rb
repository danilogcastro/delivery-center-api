# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Seeding..."

file = 'payload.json'

payload = PayloadParser.new(file)

customer1 = Customer.new(payload.create_customer)
customer1.save!

payment1 = Payment.new(payload.create_payment[0])
item1 = Item.new(payload.create_item[0])
order1 = Order.new(payload.create_order)

order1.customer = customer1
order1.items << item1

payment1.order = order1

payment1.save!
item1.save!
order1.save!

puts "All done"