module ScenariosHelper
    def create_scenario_from_input(id:nil, params:nil)

        if id.present?
            scenario = Scenario.find_by_id(id)
        else
            scenario = Scenario.new
        end
        # input for basic analysis
        scenario.deposit = params[:deposit].to_i
        scenario.buying_price = params[:buying_price].to_i
        scenario.interest = params[:interest].to_f
        scenario.tenure = params[:tenure].to_i
        scenario.holding_period = params[:holding_period].to_i
        scenario.selling_price = params[:selling_price].to_i

        # input for advanced analysis
        scenario.sell_transaction_cost = params[:sell_transaction_cost].to_i
        scenario.purchase_transaction_cost = params[:purchase_transaction_cost].to_i
        scenario.rental = params[:rental].to_i
        scenario.rental_start = params[:rental_start].to_i
        scenario.rental_end = params[:rental_end].to_i

        return scenario
    end
end
