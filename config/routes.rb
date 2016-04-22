Rails.application.routes.draw do

  mount_devise_token_auth_for "User", :at => "api/auth/email"

  namespace :api do
    namespace :v2 do
      namespace :public do
        resources :entries
      end
      namespace :private do
        resource :profile
        resources :storages
        resources :entries
        resources :values
        resources :attachments do
          collection do
            put :order
          end
        end
      end
    end
  end

  namespace :exports do
    resources :entries
  end

  get  "app"    => "interface#application"
  get  "reauth" => "interface#reauth"
  get  "*unmatched_route", :to => "interface#application" if Rails.env.production?
  root "interface#landing"
end
