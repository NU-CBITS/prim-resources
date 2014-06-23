Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' }, path: '' do
    namespace :v1 do
      resources :participants
    end
  end
end
