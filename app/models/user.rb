class User < ApplicationRecord
    has_many :attendances
    has_many :events, through: :attendances 

    has_many :expenses, through: :attendances 

    has_many :creditor_relationships, class_name: "Debt", foreign_key: :debtor_id, dependent: :destroy 
    has_many :debtor_relationships, class_name: "Debt", foreign_key: :creditor_id, dependent: :destroy


    #it returns a hash now
    def what_do_i_owe(event = Event.find_by(name: "Consolidation"))
        # Debt.select{|debt| debt.event == event && debt.debtor == self} #this used to work, but idk what happened 



        my_debts = {}
        Debt.all.each do |this_debt|
            if this_debt.debtor == self
                amount = this_debt.amount
                Debt.all.each do |that_debt|
                    if this_debt!=that_debt && this_debt.debtor == that_debt.debtor && this_debt.creditor == that_debt.creditor && !my_debts[this_debt.creditor]
                        amount += that_debt.amount
                    end
                end
                my_debts[this_debt.creditor] = amount 
            end
        end

        # #reverse reverse
        # Debt.all.each do |this_debt|
        #     ### for *each* CONSOLIDATION Debt, find any where the creditor and debtor are reversed, and make the difference ( only if !=0 ) into a new debt object, and delete the two old ones
        #     if this_debt.event == consolidation_ev
        #       Debt.all.each do |that_debt|
        #           if that_debt.event == consolidation_ev && this_debt.debtor == that_debt.creditor && this_debt.creditor == that_debt.debtor
        #               amount = this_debt.amount - that_debt.amount
        #               if amount > 0
        #                   Debt.create(event: consolidation_ev, creditor: this_debt.creditor, debtor: this_debt.debtor, amount: amount)
        #               elsif amount < 0
        #                   Debt.create(event: consolidation_ev, creditor: that_debt.creditor, debtor: that_debt.debtor, amount: -amount)
        #               end #nothing if amount = 0; no new Debt, just delete old ones; they're paid off
        #               this_debt.destroy
        #               that_debt.destroy
        #               break
        #           end
        #       end
        #     end
        # end
    end
    
    def what_is_owed_to_me(event = Event.find_by(name: "Consolidation"))
        # Debt.select{|debt| debt.event == event && debt.creditor == self}

        my_debts = {}
        Debt.all.each do |this_debt|
            if this_debt.user == self
                amount = this_debt.amount
                Debt.all.each do |that_debt|
                    if this_debt!=that_debt && this_debt.debtor == that_debt.debtor && this_debt.creditor == that_debt.creditor && !my_debts[this_debt.creditor]
                        amount += that_debt.amount
                    end
                end
                my_debts[this_debt.creditor] = amount 
            end
        end
    end
    
end
