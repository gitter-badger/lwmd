# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Member.create(first_name: "PTC",
              last_name: "Admin",
              email: ENV['EMAIL_FROM_ADDRESS'],
              cell_phone: "412-555-1212",
              password: ENV['ADMIN_PASSWORD'],
              is_admin: true)
