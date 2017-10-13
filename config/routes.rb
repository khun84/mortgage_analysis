Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # FACEBOOK AUTHENTICATION
    get "/auth/:provider/callback" => "sessions#create_from_omniauth"
    root 'static#index'
    resources :users

    post '/sign_up' => 'sessions#create_from_omniauth', as: :sign_up
    post '/sign_in' => 'sessions#create_from_omniauth', as: :sign_in
    delete '/sign_out' => 'sessions#destroy', as: :sign_out
end
