Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace 'api', defaults: { format: 'json' } do
    resources :players, except: %i[new edit]

    resources :teams, path: 'team', only: :none do
      post :process, action: 'selection', on: :collection
    end
  end
end
