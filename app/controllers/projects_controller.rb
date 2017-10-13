class ProjectsController < ApplicationController
    include SessionsHelper
    before_action do
        # check sign in
        if !signed_in?
            flash[:error] = 'Please sign in to perform this action'
            redirect_back fallback_location: root_path
            return false
        end
    end

    before_action only: [:edit, :update, :destroy] do
        # check resource existance
        project = Project.find_by(id: params[:id])
        if !project.present?
            flash[:error] = 'The project does not exist'
            redirect_back fallback_location: root_path
            return false
        end

        # check resource owner
        if project.user_id != current_user.id
            flash[:error] = 'You do not have the permission to perform this action'
            redirect_back fallback_location: root_path
            return false
        end
    end

    def index
        @projects = current_user.projects
        render 'index'
    end

    def new

    end

    def create

    end

    def edit

    end

    def update

    end

    def destroy

    end

end
