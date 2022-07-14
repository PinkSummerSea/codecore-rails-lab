Rails.application.routes.draw do

  get "/home" => "welcome#home"
  get "/about" => "welcome#about"
  get "/contact_us" => "welcome#contact_us"
  get "/thank_you" => "welcome#thank_you"
  get "/new" => "bills#new"
  get "/admin/panel" => "welcome#admin_panel"
  
  resources :products do
    resources :reviews, only: [:create, :edit, :update, :destroy]
  end

  patch "/products/:product_id/reviews/:id/edit" => "reviews#change", :as => :change

  root "products#index"

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]
end
