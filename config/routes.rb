Rails.application.routes.draw do
  root to: "dashboard#index"

  get "/projects" => "projects#index"
  get "/projects/:id" => "projects#show", :as => :project
end
