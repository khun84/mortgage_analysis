require 'rails_helper'

RSpec.describe Scenario, type: :model, focus: true do
    describe '#calculate_irr' do

        context 'valid input' do
            it 'should return the irr rate' do
                scenario = build(:scenario)
                cash_flow = [-10,-10, -10, -20, 60]
                irr = scenario.calculate_irr(0, 0.15, cash_flow)*100
                expect(irr).to be_within(0.5).of(8.42)
            end
        end

        context 'invalid input' do
            it 'should raise runtime error' do
                scenario = build(:scenario)
                cash_flow = [-10,-10,-10,10]
                expect{ scenario.calculate_irr(0, 0.15, cash_flow) }.to raise_error RuntimeError
            end
        end
    end
end