class Event < ApplicationRecord

    has_many :attendances 
    has_many :users, through: :attendances

    has_many :expenses, through: :attendances
    has_many :debts

    def attendee_user_insts
        user_id_arr = self.attendances.pluck(:user_id).uniq
        users_inst_arr = []
        user_id_arr.each { |id| users_inst_arr << User.find(id) }
        users_inst_arr
    end 
end


