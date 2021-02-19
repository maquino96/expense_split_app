class Event < ApplicationRecord

    has_many :attendances, dependent: :destroy 
    has_many :users, through: :attendances

    has_many :expenses, through: :attendances
    has_many :debts, dependent: :destroy 

    validates :date, presence: true
    validates :name, presence: true

    # def attendee_user_insts
    #     user_id_arr = self.attendances.pluck(:user_id).uniq
    #     users_inst_arr = []
    #     user_id_arr.each { |id| users_inst_arr << User.find(id) }
    #     users_inst_arr
    # end 

    def finish
        self.update(complete: true)
        debt_collector
        self.complete   #return value
    end

    def unfinish
        self.update(complete: false)
        debt_destroyer
        self.complete   #return value
    end

    def debt_collector
        total = self.expenses.sum{|ex| ex.cost}.to_f # tally all this event's expenses 
        share = total / (self.attendances.count+0.0)  # find one evenly split share

        in_the_black = {}   # people owe them
        in_the_red = {}     # they owe people
        self.attendances.each do |attendance|
            disparity = attendance.expenses.sum{|ex| ex.cost}.to_f - share
            if disparity < 0
                in_the_red[attendance.user] = -disparity
            elsif disparity > 0
                in_the_black[attendance.user] = disparity
            end  #zeroes go nowhere... they are all paid up! ## <-- this should be tested in examples
        end

        debts = []
        in_the_black.each do |creditor_person, amount|
            #for each *positive* disparity (somebody owes them), start a while loop until the disparity is 0, and each time create a Debt instance with the positive disparity, a portion of their disparity, a negative disparity, and a portion of their negative
            while in_the_black[creditor_person] > 0.0001 
                debtor_person = in_the_red.find{|attendee, amount| amount!=0}[0]
                amt = [ in_the_black[creditor_person], in_the_red[debtor_person] ].min  #between the two values, the amt the pos person is owed and the amt the neg person owes, finds the smaller of the two
                debts << Debt.create(event: self, creditor: creditor_person, debtor: debtor_person, amount: amt)
                in_the_black[creditor_person] = in_the_black[creditor_person] - amt
                in_the_red[debtor_person] = in_the_red[debtor_person] - amt
            end
        end 
        
        debts
    end

    def debt_destroyer
        self.debts.each{|debt| debt.destroy}
    end

end


