class Scenario < ApplicationRecord
    validates :deposit, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
    validates :interest, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 20}
    validates :buying_price, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates :selling_price, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates :tenure, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 5, less_than_or_equal_to: 40}

    belongs_to :project

end
