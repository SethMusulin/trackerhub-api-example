Rails.application.routes.draw do
  root to: "dashboard#index"

  get "/projects" => "projects#index"
  get "/projects/:id" => "projects#show", :as => :project

  get "/projects/:id/repo/:owner/:repo/sha/:sha/comments/new" => "git_hub_comments#new", :as => :new_git_hub_comment
  post "/projects/:id/repo/:owner/:repo/sha/:sha/comments" => "git_hub_comments#create", :as => :git_hub_comments
end
