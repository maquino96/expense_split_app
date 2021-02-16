# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user1 = User.create(name: 'Matt')
user2 = User.create(name: 'Zak')
user3 = User.create(name: 'Jack')

event1 = Event.create(complete: false, name: 'Disney Trip' , date: Date.parse('2019-08-20'))
event2 = Event.create(complete: false, name: 'Summer Vacay' , date: Date.parse('2019-07-16'))
event3 = Event.create(complete: false, name: 'Spontaneous', date: Date.parse('2020-01-17'))


attended1 = Attendance.create(user_id: 1, event_id: 1)
attended2 = Attendance.create(user_id: 1, event_id: 2)
attended3 = Attendance.create(user_id: 1, event_id: 3)
attended4 = Attendance.create(user_id: 2, event_id: 2)
attended5 = Attendance.create(user_id: 2, event_id: 3)
attended6 = Attendance.create(user_id: 3, event_id: 3)

expense1 = Expense.create(description: 'Plane tickets' , cost: 400 , attendance_id: 1)
expense2 = Expense.create(description: 'Hotel', cost: 350, attendance_id: 1)
expense3 = Expense.create(description: 'Rental Car', cost: 125, attendance_id: 2)
expense4 = Expense.create(description: 'AirBnB', cost: 235, attendance_id: 2)
expense5 = Expense.create(description: 'Private Jet', cost: 100000 , attendance_id: 3)
expense6 = Expense.create(description: 'Gen Cost', cost: 175 , attendance_id: 4)
expense6 = Expense.create(description: 'Example', cost: 215 , attendance_id: 4)
expense6 = Expense.create(description: 'Pilota', cost: 20000, attendance_id: 5)
expense6 = Expense.create(description: 'Banger', cost: 15000 , attendance_id: 6)
expense6 = Expense.create(description: 'Fun', cost: 25000 , attendance_id: 6)

puts '##### SEED COMPELTED #####'