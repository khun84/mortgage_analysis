class ScenariosController < ApplicationController
    include ScenariosHelper

    before_action except: :analyse do
        # check sign in
        if !signed_in?
            flash[:error] = 'Please sign in to perform this action'
            redirect_back fallback_location: root_path
            return false
        end
    end

    before_action only: [:show, :edit, :update, :destroy] do
        # check resource existance
        scenario = Scenario.find_by(id: params[:id])
        if !scenario.present?
            flash[:error] = 'The scenario does not exist'
            redirect_back fallback_location: root_path
            return false
        end

        # check resource owner
        if scenario.project.user_id != current_user.id
            flash[:error] = 'You do not have the permission to perform this action'
            redirect_back fallback_location: root_path
            return false
        end
    end

    def analyse

        @scenario = create_scenario_from_input(params: scenario_params)

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

        if signed_in? && @success && params[:commit] == 'Save'
            @scenario.project_id = params[:project_id]
            if @scenario.save
                # successfully save then redirect to the scenario show page
                flash[:notice] = 'Scenario has been saved.'
                redirect_to project_scenario_path(@scenario.project_id, @scenario.id)
                return
            else
                # failed to save, show the error message and continue
                flash[:error] = @scenario.errors.messages.to_s
            end
        end

        # if not sign in, show analysis result using ajax
        respond_to do |format|
            format.html {render 'static/home', locals: {input: user_input}}
            format.js {render 'scenario'}
        end

    end

    def new
        @input = ScenariosExtension::DefaultInput.new
        @project = Project.find_by_id(params[:project_id])
        render 'new'
    end

    def show
        @scenario = Scenario.find_by_id(params[:id])
        @input = @scenario.get_input
        render 'show'
    end

    def update
        @scenario = create_scenario_from_input(id: params[:id], params: scenario_params)
        @success = @scenario.advance_analysis!

        if !@success
            flash[:error] = @scenario.errors.messages[:irr]
        end

        if params[:commit] == 'Save'
            if @scenario.save
                flash[:notice] = 'Scenario has been updated!'
            else
                flash[:error] = @scenario.errors.messages
            end
        end

        respond_to do |format|
            format.html
            format.js { render 'scenario' }
        end

    end

    def destroy
        scenario = Scenario.find_by_id(params[:id])
        if scenario.destroy
            flash[:notice] = 'Scenario has been deleted!'
        else
            flash[:error] = scenario.error.messages
        end

        redirect_to project_path(scenario.project_id)
    end

    private

    def scenario_params
        params.require(:scenario).permit(:name, :deposit, :buying_price, :selling_price,
                                         :interest, :holding_period, :tenure,
                                        :purchase_transaction_cost, :sell_transaction_cost, :rental,
                                        :rental_start, :rental_end)
    end
end
