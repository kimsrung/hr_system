# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: 'admin@hr.com', password: 'admin123')
company = Company.create(name: 'Knit')
Employer.create(name: 'Eloit', email: 'eloit@knit.com', password: 'eloit123', company: company)
Employee.create(name: 'Kimsrung', email: 'kimsrung@knit.com', password: 'kimsrung123', company: company)