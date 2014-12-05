Rails.application.routes.draw do
  namespace :prim_engine, path: '' do
    namespace :api, defaults: { format: 'json' }, path: '' do
      namespace :v1 do
        resources :addresses, except: [:edit, :new]
        resources :emails, except: [:edit, :new]
        resources :participants, except: [:edit, :new]
        resources :phones, except: [:edit, :new]
        resources :screenings, except: [:edit, :new]
        resources :statuses, except: [:edit, :new]
      end

      namespace :v2 do
        resources :projects, only: [:index, :show]
      end
    end
  end
end
