Rails.application.routes.draw do
  devise_for :admins
  namespace :admin do
    resources :documents do
      get 'download_assigned_file', on: :member
      get 'download_submitted_file', on: :member
    end
    resources :employers
    resources :employees
    resources :companies
    root to: 'dashboard#index'
  end

  devise_for :employers
  namespace :employer do
    resources :documents do
      get 'download_assigned_file', on: :member
      get 'download_submitted_file', on: :member
    end
    resources :employees
    resources :companies
    root to: 'dashboard#index'
  end

  devise_for :employees
  namespace :employee do
    resources :documents, only: [:index, :show, :edit, :update] do
      get 'download_assigned_file', on: :member
      get 'download_submitted_file', on: :member
    end
    root to: 'documents#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
