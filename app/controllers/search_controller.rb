class SearchController < ApplicationController
    # check sign in
    before_action do
        if !signed_in?
            flash[:error] = 'Please sign in to perform this action'
            redirect_back fallback_location: root_path
        end
    end

    def new_search
        @input = ScenariosExtension::DefaultInput.new
        render 'new'
    end

    def show_search
        @scenarios = Scenario.search(search_params).includes(:project).order('projects.title, scenarios.name, scenarios.irr desc')

        respond_to do |format|
            format.html {render partial: 'index', collection: @scenarios, as: :scenario}
            format.js { render 'search_result' }
        end
    end

    private
    def search_params
        params.require(:search).permit(:project_title, :scenario_name, :irr)
    end

end
