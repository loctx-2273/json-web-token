Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: {format: :json} do
      post "user/login", to: "authenticate#create"
      delete "user/logout", to: "authenticate#destroy"
    end
  end
end
