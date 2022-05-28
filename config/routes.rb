Rails.application.routes.draw do

  root 'public/homes#top'
  
  #ゲストログインの記述
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  # #管理者ログイン用
  # devise_for :admins, skip: [:registrations, :passwords],controllers: {
  #   sessions: "admins/sessions"
  # }
  devise_for :admins, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  namespace :admin do
    resources :blogs, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
  end

    resources :users, only: [:index, :show, :edit, :update]
  end


  namespace :public do
    
    get 'relationships/followings'
    get 'relationships/followers'

    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'
    #検索機能
    get "search" => "searches#search"
    #タグ検索
    get "search_tag"=>"blogs#search_tag"

    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :favorites
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end  

    resources :blogs, only: [:new, :create, :index,:show, :edit, :update,:destroy,] do
      resource :favorites, only: [:create,:destroy]
      resources :comments, only: [:create, :destroy]
    end  


  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
