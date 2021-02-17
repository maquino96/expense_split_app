class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :expenses, dependent: :destroy 

  validate :unique_attendee

  def unique_attendee
    if Attendance.find_by(user_id: self.user_id, event_id: self.event_id)
      self.errors.add(:user_id, 'has already connected to this event' )
    end 
  end 

  # def expenses
  #   Expense.all.select{ |expense| expense.attendance_id == id}
  # end 

end
