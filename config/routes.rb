Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :forecast, only: :show

      resource :backgrounds, only: :show
    end
  end
end
