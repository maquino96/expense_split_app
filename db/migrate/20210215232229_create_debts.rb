class CreateDebts < ActiveRecord::Migration[6.1]
  def change
    create_table :debts do |t|
      t.integer :debtor_id
      t.integer :creditor_id
      t.integer :amount
      t.belongs_to :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
