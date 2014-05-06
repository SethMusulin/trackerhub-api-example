class ProjectsController < ApplicationController
  def index
    @projects = TrackerApi.new.projects
  end

  def show
    @stories          = TrackerApi.new.stories(:project_id => params[:id])
    @tracker_comments = TrackerApi.new.comments(:project_id => params[:id],
                                                :story_ids  => @stories.map(&:id))
    @github_comments  = GitHubApi.new.comments_for(:tracker_comments => @tracker_comments)
  end
end