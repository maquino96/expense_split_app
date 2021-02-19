class Expense < ApplicationRecord
    belongs_to :attendance

    validates :description, presence: true
    validates :cost, presence: true

end
