class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.boolean :complete
      t.string :name
      t.date :date

      t.timestamps
    end
  end
end
