# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


matt = User.create(name: 'Matt')
zak = User.create(name: 'Zak')
jack = User.create(name: 'Jack')

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
expense7 = Expense.create(description: 'Example', cost: 215 , attendance_id: 4)
expense8 = Expense.create(description: 'Pilota', cost: 20000, attendance_id: 5)
expense9 = Expense.create(description: 'Banger', cost: 15000 , attendance_id: 6)
expense10 = Expense.create(description: 'Fun', cost: 25000 , attendance_id: 6)

puts '##### MATT SEED COMPELTED #####'

john = User.create(name: "John")
paul = User.create(name: "Paul")
george = User.create(name: "George")
ringo = User.create(name: "Ringo")

yellowsubmarine = Event.create(name: "Yellow Submarine", date: Date.parse('1967-08-20'))

ysjohn = Attendance.create(user: john, event: yellowsubmarine)
yspaul = Attendance.create(user: paul, event: yellowsubmarine)
ysgeorge = Attendance.create(user: george, event: yellowsubmarine)
ysringo = Attendance.create(user: ringo, event: yellowsubmarine)

Expense.create(attendance: ysjohn, description: "all you need is love", cost: 90)
Expense.create(attendance: ysjohn, description: "baby's in black", cost: 50)
Expense.create(attendance: ysjohn, description: "can't buy me love", cost: 25)
Expense.create(attendance: yspaul, description: "don't let me down", cost: 70)
Expense.create(attendance: yspaul, description: "eight days a week", cost: 15)
Expense.create(attendance: ysgeorge, description: "fixing a hole", cost: 11)
Expense.create(attendance: ysgeorge, description: "golden slumbers", cost: 4)
Expense.create(attendance: ysgeorge, description: "help!", cost: 5)
Expense.create(attendance: ysgeorge, description: "i wanna hold your hand", cost: 13)

puts '##### ZAK SEED COMPELTED #####'

event4 = Event.create(name: "Dinner that one time", date: Date.parse('2016-02-19'))
attended7 = Attendance.create(user: zak, event: event4)
attended8 = Attendance.create(user: matt, event: event4)
attended9 = Attendance.create(user: ringo, event: event4)
attended10 = Attendance.create(user: paul, event: event4)
attended11 = Attendance.create(user: jack, event: event4)
Expense.create(attendance: attended8, description: "apps", cost: 200)

event5 = Event.create(name: "Just Hangin", date: Date.parse('2020-03-15'))
attended12 = Attendance.create(user: matt, event: event5)
attended13 = Attendance.create(user: jack, event: event5)
Expense.create(attendance: attended12, description: "sushi!!!", cost: 18)


puts '##### ALL SEED COMPELTED #####'