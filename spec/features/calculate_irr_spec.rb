require 'rails_helper'

feature 'calculate_irr', type: :feature do
    scenario 'non registered user', js:true do
        visit '/'
        find('input[value="Calculate"]').click
        sleep 2
        irr = find('#output-irr').text.to_f
        expect(irr).to be_within(0.5).of(32.3)
    end

    scenario 'registered user', js:true do
        user = create(:user)
        page.set_rack_session('user_id'=>user.id)

        visit '/'
        page.find('input[value="Calculate"]').click
        sleep 2
        irr = page.find('#output-irr').text.to_f
        expect(irr).to be_within(0.5).of(44.7)
    end
end