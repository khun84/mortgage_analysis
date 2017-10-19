class Project < ApplicationRecord
    include ScenariosExtension
    validates :title, presence: true, length: {in: DefaultInput.project_name.min..DefaultInput.project_name.max}
    validates :description, length: {maximum: DefaultInput.project_description.max, too_long: "%{count} characters is the maximum allowed"}

    belongs_to :user
    has_many :scenarios, dependent: :destroy

end
