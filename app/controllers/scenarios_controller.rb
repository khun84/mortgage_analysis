class ScenariosController < ApplicationController

    def create
        @scenario = Scenario.new
        @scenario.deposit = scenario_params[:deposit].to_i
        @scenario.buying_price = scenario_params[:buying_price].to_i
        @scenario.interest = scenario_params[:interest].to_f
        @scenario.tenure = scenario_params[:tenure].to_i
        @scenario.holding_period = scenario_params[:holding_period].to_i
        @scenario.selling_price = scenario_params[:selling_price].to_i

        if !@scenario.basic_analysis!
            flash[:error] = @scenario.errors.messages[:irr]
            @success = false
        else
            @success = true
        end

        user_input = @scenario.get_input
        respond_to do |format|
            format.html {render 'static/home', locals: {input: user_input}}
            format.js {render 'scenario'}
        end
    end

    private

    def scenario_params
        params.require(:scenario).permit(:deposit, :buying_price, :selling_price, :interest, :holding_period, :tenure)
    end
end
