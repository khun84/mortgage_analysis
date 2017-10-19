require 'rails_helper'
include ScenariosExtension

RSpec.describe Project, type: :model, focus: true do
    describe 'validations' do
        context 'validates project title' do
            it { is_expected.to validate_presence_of(:title) }
        end

        context 'validates length of title and description' do
            it { is_expected.to validate_length_of(:title).is_at_least(DefaultInput.project_name.min).is_at_most(DefaultInput.project_name.max) }
            it { is_expected.to validate_length_of(:description).is_at_most(DefaultInput.project_description.max).with_message("#{DefaultInput.project_description.max} characters is the maximum allowed") }
        end
    end

    describe 'association with dependency' do
        it { is_expected.to belong_to(:user) }
        it { is_expected.to have_many(:scenarios).dependent(:destroy) }
    end
end

