class User < ApplicationRecord
    has_many :attendances
    has_many :events, through: :attendances 

    has_many :expenses, through: :attendances 

    has_many :creditor_relationships, class_name: "Debt", foreign_key: :debtor_id, dependent: :destroy 
    has_many :debtor_relationships, class_name: "Debt", foreign_key: :creditor_id, dependent: :destroy
end
