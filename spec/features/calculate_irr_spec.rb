require 'rails_helper'

feature 'calculate_irr', type: :feature do
    scenario 'non registered user', js:true do
        visit '/'
        find('input[value="Calculate"]').click
        irr = find('#output-irr').text.to_f
        # expect(irr).to be_within(0.5).of(32.3)
        # sleep 5
        expect(irr).to be_within(0.5).of(32.3)
    end
end