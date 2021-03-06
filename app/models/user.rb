class User < ApplicationRecord
    has_many :attendances
    has_many :events, through: :attendances 

    has_many :expenses, through: :attendances 

    has_many :creditor_relationships, class_name: "Debt", foreign_key: :debtor_id, dependent: :destroy 
    has_many :debtor_relationships, class_name: "Debt", foreign_key: :creditor_id, dependent: :destroy

    validates :name, presence: true

    # they return a hash now
    def what_do_i_owe
        calculate
        @my_debts
    end

    def what_is_owed_to_me
        calculate
        @rightful_dues
    end

    # private

    def calculate
        @my_debts = {}
        @rightful_dues = {}
        calculate_debts
        calculate_dues
        owe_is_me
    end

    def calculate_debts
        Debt.all.each do |this_debt|
            if this_debt.debtor == self && !@my_debts[this_debt.creditor]
                amount = this_debt.amount
                Debt.all.each do |that_debt|
                    if this_debt!=that_debt && this_debt.debtor == that_debt.debtor && this_debt.creditor == that_debt.creditor 
                        amount += that_debt.amount
                    end
                end
                @my_debts[this_debt.creditor] = amount 
            end
        end
    end
    
    def calculate_dues
        Debt.all.each do |this_debt|
            if this_debt.creditor == self && !@rightful_dues[this_debt.creditor]
                amount = this_debt.amount
                Debt.all.each do |that_debt|
                    if this_debt!=that_debt && this_debt.debtor == that_debt.debtor && this_debt.creditor == that_debt.creditor
                        amount += that_debt.amount
                    end
                end
                @rightful_dues[this_debt.debtor] = amount 
            end
        end
    end

    def owe_is_me       #it's a pun ("woe is me")
        #reverse reverse
        @my_debts.each do |my_creditor, debt|
            @rightful_dues.each do |my_debtor, credit|
                if my_debtor == my_creditor
                    amount = credit - debt
                    if amount > 0
                        @rightful_dues[my_debtor] = amount
                        @my_debts.delete(my_creditor)
                    elsif amount < 0
                        @rightful_dues.delete(my_debtor)
                        @my_debts[my_creditor] = -amount
                    else    #amount = 0, they are even, delete both debts
                        @rightful_dues.delete(my_debtor)
                        @my_debts.delete(my_creditor)
                    end
                    break
                end
            end
        end
    end

    # #this method should settle any "cycle debts" (e.g. if three people each owe the person to their left $5, nobody owes anything)
    # ### if done correctly, this might be able to replace the user#owe_is_me method, because that is looking for 2-cycles, and this is looking for N-cycles
    # ### i.e. it's just more generalized.
    # def self.handle_cycle_debts_or_something
    #   #this logic will be hard
    #   ### might involve graph theory??? Looking for circuits and cycles in a debt network ??
    # end




    # def what_do_i_owe
    #     my_debts = {} 
    #     debts = Debt.select{|debt| debt.debtor == self} 
    #     dues = Debt.select{|debt| debt.creditor == self}
    #     byebug
    #     debts.each do |this_debt|
    #         if !my_debts[this_debt.creditor]
    #             amount = this_debt.amount
    #             debts.each do |that_debt|
    #                 if this_debt != that_debt && this_debt.creditor == that_debt.creditor
    #                     amount += that_debt.amount
    #                     byebug
    #                 end
    #             end
    #             my_debts[this_debt.creditor] = amount
    #         end
    #     end
    #     byebug
    #     my_debts.each do |creditor, amt|
    #         dues.each do |due|
    #             if creditor == due.debtor
    #                 amt -= due.amount
    #             end
    #         end
    #         my_debts[creditor] = amt
    #     end
    #     byebug
    #     my_debts
    # end
    
end
