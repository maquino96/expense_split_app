class User < ApplicationRecord
    has_many :attendances
    has_many :events, through: :attendances 

    has_many :expenses, through: :attendances 

    has_many :creditor_relationships, class_name: "Debt", foreign_key: :debtor_id, dependent: :destroy 
    has_many :debtor_relationships, class_name: "Debt", foreign_key: :creditor_id, dependent: :destroy


    ###############
    #### in User class; this method should return an array of Debt objects where the calling user is the *debtor* (i.e. they owe others)
    def what_do_i_owe(event = Event.find_by(name: "Consolidation"))
        # event ? evnts = [event] : evnts = self.events   # "evnts" is either *just* the one event instance passed in, or *all* of the user's events if no event specified
        # #should i just have them pass in an *array* of events instead?

        # my_debts = []
        # evnts.each do |evnt|
        #     my_debts << evnt.debts.select{|debt| debt.debtor==self}
        # end
        
        # my_debts.flatten

        Debt.select{|debt| debt.event == event && debt.debtor == self}
    end
    #### in User class; this method should return an array of Debt objects where the calling user is the *creditor* (i.e. others owe them)
    def what_is_owed_to_me(event = Event.find_by(name: "Consolidation"))
        # event ? evnts = [event] : evnts = self.events   # "evnts" is either *just* the one event instance passed in, or *all* of the user's events if no event specified
        # #should i just have them pass in an *array* of events instead?

        # rightful_dues = []
        # evnts.each do |evnt|
        #     rightful_dues << evnt.debts.select{|debt| debt.creditor==self}
        # end
        
        # rightful_dues.flatten

        Debt.select{|debt| debt.event == event && debt.creditor == self}
    end
end
