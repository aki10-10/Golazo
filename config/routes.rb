Rails.application.routes.draw do
  namespace :public do
    get 'accounts/unsbscribe'
  end
  root 'public/homes#top'

  devise_scope :user do #ゲストログインの記述
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  namespace :public do

    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'


    resources :users, only: [:index, :show, :edit, :update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
