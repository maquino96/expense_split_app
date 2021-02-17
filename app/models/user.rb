class User < ApplicationRecord
    has_many :attendances
    has_many :events, through: :attendances 

    has_many :expenses, through: :attendances 

    has_many :creditor_relationships, class_name: "Debt", foreign_key: :debtor_id, dependent: :destroy 
    has_many :debtor_relationships, class_name: "Debt", foreign_key: :creditor_id, dependent: :destroy


   
    def what_do_i_owe(event = Event.find_by(name: "Consolidation"))
        Debt.select{|debt| debt.event == event && debt.debtor == self}
    end
    
    def what_is_owed_to_me(event = Event.find_by(name: "Consolidation"))
        Debt.select{|debt| debt.event == event && debt.creditor == self}
    end
    
end
