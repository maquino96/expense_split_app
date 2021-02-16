class Debt < ApplicationRecord
  belongs_to :event

  belongs_to :debtor, class_name: "User", foreign_key: "debtor_id"
  belongs_to :creditor, class_name: "User", foreign_key: "creditor_id"

  def to_s
    "#{self.debtor.name} owes #{self.creditor.name} $#{self.amount.round(2)}."
  end
   
end
