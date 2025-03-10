Rails.application.routes.draw do
  root 'public/users#top'

  get 'inquiry/index',    to:'inquiry#index'
  get 'inquiry/confirm',  to:'inquiry#confirm'
  get 'inquiry/thanks',   to:'inquiry#thanks'
  get 'prof/index',     to:'prof#index'

  devise_for :admins
  namespace :admins do
    resources :photos
    resources :users, only:[:index,:edit,:update,:delete,:show]
    resources :order, only:[:index,:edit,:update,:show]
    resources :users, only:[:edit,:update,]
    resources :order_details, only:[:edit,:update]

    resources :photos, only: [:index, :create, :destroy,:update,:edit]do
      collection do
        get "top"
      end
    end
    resources :likes, only: [:index, :create, :destroy]
    resources :users, only: [:index,:edit,:destroy,:update]
    resources :orders, only: [:index,:show]
  end
  devise_for :users, controllers: {
    sessions: "users/sessions" ,
    registrations: "users/registrations"
  }
  namespace :public do
    get 'cards/index'
    resources :users, only:[:show,:edit,:update,]do
      member do
        get :following, :followers
      end
      collection do
        get "about"
        get "tomo"
        get "my_page"
        get "search"
        get "users_unsubscribe" => "userr#unsubscribe"
        delete "users_withdraw" => "users#withdraw"
      end
    end
    resources :credit_cards, only: [:edit,:create,:show]do
      member do
        get "confirmation"
      end
      collection do
        post 'delete',to:'credit_card#delete'
        post 'show'
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :cart_items, only:[:index,:create,:update,:destroy]do
      collection do
        delete "delete_all"
      end
    end
    resources :order_details ,only:[:index, :create,:edit ,:update]
    resources :orders, only:[:new,:index,:create,:show,:update] do
      member do
        get "sold"
        get "sold_detail"
      end
      collection do
        get "confirm"
        get "complete"
      end
    end
    resources :book_marks, only:[:index]
    resources :gallaries, only:[:new,:index,:edit,:create,:update,:delete]
    resources :photos do
      get 'search'
      collection do 
        get 'hashtag'
      end
      resources :likes, only: [:index, :create, :destroy]
    end
    get "/credits" => "credits#index"
    get '/hashtag' => 'photos#hashtag'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
