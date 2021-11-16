Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :forecast, only: :show

      resource :backgrounds, only: :show

      resource :activities, only: :show

      resources :users, only: :create

      resources :sessions, only: :create

      resource :road_trip, only: :create
    end
  end
end
