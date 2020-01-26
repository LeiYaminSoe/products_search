Rails.application.routes.draw do
  root "products#index"
  resources :tags
  resources :products
  get "products/product_detail" => 'products#product_detail', :as => :product_detail  
  post "products/product_sorting" => 'products#product_sorting', :as => :product_sorting

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
