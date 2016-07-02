Rails.application.routes.draw do
  namespace :events do
    resources :events
  end
end
