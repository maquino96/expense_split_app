class Debt < ApplicationRecord
  belongs_to :event

  belongs_to :debtor, class_name: "User", foreign_key: "debtor_id"
  belongs_to :creditor, class_name: "User", foreign_key: "creditor_id"


  #this method should condense one-way debts involving the same two people
  #should this get called... when? Every time a new event is finished?
  def self.consolidate     # needs to be a class method ? i think so
    consolidation_ev = Event.find_by(name: "Consolidation")
    #look through all the debts
    Debt.all.each do |this_debt|
        ### for *each* debt instance, see if there are any with the same exact debtor and creditor, and if so add them all together, into a new Debt, and delete all old ones.
        if this_debt.event != consolidation_ev
          amount = this_debt.amount
          Debt.all.each do |that_debt|
              if this_debt!=that_debt && that_debt.event != consolidation_ev && this_debt.debtor == that_debt.debtor && this_debt.creditor == that_debt.creditor
                  amount += that_debt.amount
              end
          end
          new_ish_debt = Debt.find_or_create_by(event: consolidation_ev, creditor: this_debt.creditor, debtor: this_debt.debtor)
          new_ish_debt.update(amount: amount)
        end
    end
    ## call reverse_dupli_method before we're done
    Debt.reversy_thingy # (the method below, without a good name)
  end
  #
  def self.reversy_thingy   #should only get called after the previous method, never from the beyond (maybe i should make it private). Functionality depends on one-way duplicates already being condensed
    consolidation_ev = Event.find_by(name: "Consolidation")
    #look through all the CONSOLIDATION debts
    Debt.all.each do |this_debt|
        ### for *each* CONSOLIDATION Debt, find any where the creditor and debtor are reversed, and make the difference ( only if !=0 ) into a new debt object, and delete the two old ones
        if this_debt.event == consolidation_ev
          Debt.all.each do |that_debt|
              if that_debt.event == consolidation_ev && this_debt.debtor == that_debt.creditor && this_debt.creditor == that_debt.debtor
                  amount = this_debt.amount - that_debt.amount
                  if amount > 0
                      Debt.create(event: consolidation_ev, creditor: this_debt.creditor, debtor: this_debt.debtor, amount: amount)
                  elsif amount < 0
                      Debt.create(event: consolidation_ev, creditor: that_debt.creditor, debtor: that_debt.debtor, amount: -amount)
                  end #nothing if amount = 0; no new Debt, just delete old ones; they're paid off
                  this_debt.destroy
                  that_debt.destroy
                  break
              end
          end
        end
    end
  end

  #this method should settle any "cirlce debts" (e.g. if three people each owe the person to their left $5, nobody owes anything)
  ### if done correctly, this might be able to replace the Debt.reversy_thingy method above, because that is looking for 2-cycles, and this is looking for N-cycles
  ### i.e. it's just more generalized.
  def self.handle_circle_debts_or_something
    #this logic will be hard
    ### might involve graph theory??? Looking for circuits and cycles in a debt network ??
  end

end
