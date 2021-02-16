class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :expenses 

  # def expenses
  #   Expense.all.select{ |expense| expense.attendance_id == id}
  # end 

end
