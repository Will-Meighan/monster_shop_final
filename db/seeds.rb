# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Merchant.destroy_all
Discount.destroy_all
Item.destroy_all
User.destroy_all
Order.destroy_all

megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)

megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 100)
megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

user = User.create!(name: 'user', address: '123 main', city: 'Denver', state: 'CO', zip: 80204, email: 'user@gmail.com', password: 'user', role: 0)
merchant_1 = megan.users.create!(name: "Meg", address: "123 main", city: "Denver", state: "CO", zip: 80204, email: "merchant1@gmail.com", password: "password", role: 1)
merchant_2 = brian.users.create!(name: "Brian", address: "123 main", city: "Denver", state: "CO", zip: 80204, email: "merchant2@gmail.com", password: "password", role: 1)
admin = User.create(name: 'admin', address: '123 main', city: 'Denver', state: 'CO', zip: 80204, email: 'admin@gmail.com', password: 'password', role: 2)

discount_1 = megan.discounts.create!(
description: 'Small Discount',
item_threshold: 20,
percent_discount: 5
)

discount_2 = megan.discounts.create!(
description: 'Large Discount',
item_threshold: 40,
percent_discount: 10
)

discount_3 = brian.discounts.create!(
description: 'Large Discount',
item_threshold: 40,
percent_discount: 10
)
