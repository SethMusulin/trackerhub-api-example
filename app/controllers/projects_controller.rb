class ProjectsController < ApplicationController
  def index
    @projects = TrackerApi.new.projects
  end

  def show
    @stories = TrackerApi.new.stories(:project_id => params[:id])
    @comments = TrackerApi.new.comments(:project_id => params[:id],
                                        :story_ids => @stories.map(&:id))
  end
end