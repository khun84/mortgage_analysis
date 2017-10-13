class Project < ApplicationRecord
    validates :title, presence: true, length: {in: 6..20}
    validates :description, length: {maximum: 200, too_long: "%{count} characteres is the maximum allowed"}

    belongs_to :user
    has_many :scenarios
end
