Rails.application.routes.draw do
  namespace :events do
    resources :events do
      resources :results
    end
  end
end
