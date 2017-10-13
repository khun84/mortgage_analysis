Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # FACEBOOK AUTHENTICATION
    get "/auth/:provider/callback" => "sessions#create_from_omniauth"

    resources :users


end
