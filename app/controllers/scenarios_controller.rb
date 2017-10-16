class ScenariosController < ApplicationController

    def analyse
        @scenario = Scenario.new
        # input for basic analysis
        @scenario.deposit = scenario_params[:deposit].to_i
        @scenario.buying_price = scenario_params[:buying_price].to_i
        @scenario.interest = scenario_params[:interest].to_f
        @scenario.tenure = scenario_params[:tenure].to_i
        @scenario.holding_period = scenario_params[:holding_period].to_i
        @scenario.selling_price = scenario_params[:selling_price].to_i

        # input for advanced analysis
        @scenario.sell_transaction_cost = scenario_params[:sell_transaction_cost].to_i
        @scenario.purchase_transaction_cost = scenario_params[:purchase_transaction_cost].to_i
        @scenario.rental = scenario_params[:rental].to_i
        @scenario.rental_start = scenario_params[:rental_period_start].to_i
        @scenario.rental_end = scenario_params[:rental_period_end].to_i

        # if the analysis return error
        if signed_in?
            @success = @scenario.advance_analysis!
        else
            @success = @scenario.basic_analysis!
        end

        if !@success
            flash[:error] = @scenario.errors.messages[:irr]
        end

        # return the user input back to front end after page refreshed
        user_input = @scenario.get_input


        respond_to do |format|
            format.html {render 'static/home', locals: {input: user_input}}
            format.js {render 'scenario'}
        end
    end

    def new
        input = ScenariosExtension::DefaultInput.new
        render 'new'
    end

    private

    def scenario_params
        params.require(:scenario).permit(:deposit, :buying_price, :selling_price,
                                         :interest, :holding_period, :tenure,
                                        :purchase_transaction_cost, :sell_transaction_cost, :rental,
                                        :rental_period_start, :rental_period_end)
    end
end
