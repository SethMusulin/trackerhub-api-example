Rails.application.routes.draw do
  root to: "dashboard#index"

  get "/projects" => "projects#index"
end
