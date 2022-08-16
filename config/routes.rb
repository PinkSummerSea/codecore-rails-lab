Rails.application.routes.draw do

  get "/home" => "welcome#home"
  get "/about" => "welcome#about"
  get "/contact_us" => "welcome#contact_us"
  get "/thank_you" => "welcome#thank_you"
  get "/new" => "bills#new"
  get "/admin/panel" => "welcome#admin_panel"
  
  resources :products do
    resources :reviews, only: [:create, :edit, :update, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
  end

  patch "/products/:product_id/reviews/:id/edit" => "reviews#change", :as => :change

  root "products#index"

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :news_articles

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :products, only: [:index, :show, :create, :update, :destroy]
      resource :session, only: [:create, :destroy]
      resources :users, only: [:create] do
        get :current, on: :collection
      end
    end
  end
end
