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

    before_action only: [:show, :edit, :update, :destroy] do
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

    def show
        @project = Project.find_by(id: params[:id])
        render 'show'
    end

    def new

    end

    def create
        project = Project.new
        project.user_id = current_user.id
        project.title = project_params[:title]
        project.description = project_params[:description]

        if project.save
            redirect_to project_path project
            return true
        else
            flash[:error] = project.errors.messages
            redirect_to projects_path
            return false
        end
    end

    def edit
        @project = Project.find_by_id(params[:id])
        render 'edit'
    end

    def update
        @project = Project.find_by_id(params[:id])
        @project.title = project_params[:title]
        @project.description = project_params[:description]
        if @project.save
            flash[:notice] = 'Successfully edited project'
        else
            flash[:error] = "Fail to edit project. #{@project.errors.messages}"
        end
        redirect_to project_path(@project.id)
    end

    def destroy
        project = Project.find_by(id: params[:id])

        if project.destroy
            flash[:notice] = "#{project.title} has been deleted."
            redirect_to projects_path
            return true
        else
            flash[:error] = "Failed to delete the project. #{project.errors.messages}"
            redirect_to project_path(project)
        end
    end

    private

    def project_params
        params.require(:project).permit(:title, :description)
    end

end
