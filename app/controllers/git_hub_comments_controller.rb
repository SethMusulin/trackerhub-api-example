class GitHubCommentsController < ApplicationController
  def new

  end

  def create
    GitHubApi.new.create_comment(params)
    redirect_to project_path(params[:id])
  end
end