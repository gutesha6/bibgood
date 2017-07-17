Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # ADMIN SECTION
  namespace :admin do
    root 'lessons#index'
    resources :lessons do
      resources :questions, shallow: true
      resources :exercizes, shallow: true
    end
  end

  # STUDIES
  resources :studies, except: %i[new create] do
    resources :study_requests, path: 'requests', as: 'request', only: %i[new create]
    resources :study_users, path: 'users', as: 'users', only: %i[new create index]
  end

  concern :commentable do
    resources :comments, only: [:create]
  end

  # GENERAL
  resources :study_questions, only: :show, concerns: :commentable
  resources :study_exercizes, only: :show, concerns: :commentable do
    post 'start', to: 'study_user_exercizes#create'
  end
  resources :comments, only: [], concerns: :commentable
  resources :study_requests, except: %i[new create destroy]
  resources :incoming_study_requests, except: %i[new create destroy]
  resources :study_users, only: :destroy
  resources :lessons, only: %i[index show] do
    resources :studies, only: %i[new create]
  end

  root 'home#index'
end
