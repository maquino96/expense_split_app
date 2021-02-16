class Debt < ApplicationRecord
  belongs_to :event

  belongs_to :debtor, class_name: "User", foreign_key: "debtor_id"
  belongs_to :creditor, class_name: "User", foreign_key: "creditor_id"

  def to_s
    "#{self.debtor.name} owes #{self.creditor.name} $#{self.amount.round(2)}."
  end

  # def to_you_owe_s
  #   "You owe #{self.creditor.name} $#{self.amount.round(2).to_s.reverse.gsub(/(\d+\.)?(\d{3})(?=\d)/, '\\1\\2,').reverse}."
  # end

  # def to_owes_you_s
  #   "#{self.debtor.name} owes you $#{self.amount.round(2).to_s.reverse.gsub(/(\d+\.)?(\d{3})(?=\d)/, '\\1\\2,').reverse}."
  # end
   

  #this method should condense debts involving the same two people
  #should this get called... when? Every time a new event is finished?
  def self.something_about_working_out_duplicates_or_whatever     # needs to be a class method ? i think so
    #look through all the debts
    Debt.all.each do |this_debt|
        ### for *each* debt instance, see if there are any with the same exact debtor and creditor, and if so add them all together, into a new Debt, and delete all old ones.
        amount = this_debt.cost
        Debt.all.each do |that_debt|
            if this_debt!=that_debt && this_debt.debtor == that_debt.debtor && this_debt.creditor == that_debt.creditor
                amount += that_debt.cost
                that_debt.destroy
            end
        end
        if amount > this_debt.cost
            Date.create(event: nil, creditor: this_debt.creditor, debtor: this_debt.debtor, cost: amount) #event must be nil because this new debt was created from multiple events, right ?
            this_debt.destroy
        end
    end
    ## call reverse_dupli_method before we're done
    Debt.reversy_thingy # (the method below, without a good name)
  end
  #
  def self.reverse_duplicate_things_idk   #should only get called after the previous method, never from the beyond (maybe i should make it private). Functionality depends on one-way duplicates already being condensed
    #look through all the debts
    Debt.all.each do |this_debt|
        ### for *each*, find any where the creditor and debtor are reversed, and make the difference ( only if !=0 ) into a new debt object, and delete the two old ones
        Debt.all.each do |that_debt|
            if this_debt.debtor == that_debt.creditor && this_debt.creditor == that_debt.debtor
                amount = this_debt.cost - that_debt.cost
                if amount > 0
                    Debt.create(event: nil, creditor: this_debt.creditor, debtor: this_debt.debtor, cost: amount)
                elsif amount < 0
                    Debt.create(event: nil, creditor: that_debt.creditor, debtor: that_debt.debtor, cost: -amount)
                end #nothing if amount = 0; no new Debt, just delete old ones; they're paid off
                this_debt.destroy
                that_debt.destroy
                break
            end
        end
    end
  end

  #this method should settle any "cirlce debts" (e.g. if three people each owe the person to their left $5, nobody owes anything)
  def self.handle_circle_debts_or_smthng
    #this logic will be hard
    ### might involve graph theory??? Looking for circuits and cycles in a debt network ??
  end

end
