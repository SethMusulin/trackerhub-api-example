class ProjectsController < ApplicationController
  def index
    @projects = TrackerApi.new.projects
  end
end