include ScenariosExtension
FactoryGirl.define do
    factory :scenario do
        name 'test scenario'
        deposit DefaultInput.deposit.base
        interest DefaultInput.interest.base
        tenure DefaultInput.tenure.base
        buying_price DefaultInput.buying_price.base
        selling_price DefaultInput.selling_price.base
        rental DefaultInput.rental.base
        rental_start DefaultInput.rental_period.min
        rental_end DefaultInput.rental_period.base
        purchase_transaction_cost DefaultInput.purchase_transaction_cost.base
        sell_transaction_cost DefaultInput.sell_transaction_cost.base
        holding_period DefaultInput.holding_period.base
        project_id nil
        irr nil
    end
end
