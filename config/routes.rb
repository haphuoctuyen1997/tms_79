Rails.application.routes.draw do
  root "static_pages#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"


  resources :users do
    member do
      get :show_profile
    end
  end
  resources :courses do
    collection do
      get :add_member
      get :add_subject
      get :delete_member
      get :delete_subject
    end
    member do
      get :member_remaining
      get :subject_remaining
    end
  end
  resources :subjects, only: %i(index show) do
    resources :tasks, except: %i(index show)
  end

  namespace :basic_trainee do
    resources :users do
      member do
        get :show_profile
      end
    end

    resources :courses, only: :show do
      resources :subjects, only: :show do
        member do
          get :start_task
          get :finish_task
        end
      end
    end

  end
end
