class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :description
      t.float :cost
      t.belongs_to :attendance, null: false, foreign_key: true

      t.timestamps
    end
  end
end
