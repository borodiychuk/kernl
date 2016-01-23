Rails.application.routes.draw do

  mount_devise_token_auth_for "User", :at => "api/auth/email"

  namespace :api do
    namespace :v1 do
      namespace :public do
        resources :products
        resources :requests
      end
      namespace :private do
        resource :profile
        resources :projects
        resources :products do
          resources :product_prices
          resources :product_variants
          resources :images do
            collection do
              put :order
            end
          end
        end
      end
    end
  end

  get  "app"    => "interface#application"
  get  "reauth" => "interface#reauth"
  get  "*unmatched_route", :to => "interface#application"
  root "interface#landing"
end
