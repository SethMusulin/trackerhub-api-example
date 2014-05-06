class ProjectsController < ApplicationController
  def index
    @projects = TrackerApi.new.projects
  end

  def show
    @stories = TrackerApi.new.stories(:project_id => params[:id])
  end
end