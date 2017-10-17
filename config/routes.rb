Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # FACEBOOK AUTHENTICATION
    get "/auth/:provider/callback" => "sessions#create_from_omniauth"
    root 'static#index'

    post '/sign_up' => 'sessions#create_from_omniauth', as: :sign_up
    post '/sign_in' => 'sessions#create_from_omniauth', as: :sign_in
    delete '/sign_out' => 'sessions#destroy', as: :sign_out

    post '/scenario' => 'scenarios#analyse', as: :analyse_scenario
    post '/projects/:project_id/scenarios/new' => 'scenarios#analyse', as: :create_projects_scenario
    patch '/projects/:project_id/scenarios/:id' => 'scenarios#update', as: :update_projects_scenario

    get '/search' => 'search#new_search', as: :new_search
    get '/search/show' => 'search#show_search', as: :show_search

    get '/forex' => 'forex#index', as: :forex
    get '/forex/get' => 'forex#get_forex', as: :get_forex

    resources :users
    resources :projects do
        resources :scenarios, except: [:create, :update]
    end

    get '/scenarios/new' => 'scenarios#create', as: :new_scenario
end
