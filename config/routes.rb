Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  scope '/api' do
    get '/movies', to: 'movies#index'
    post '/movies', to: 'movies#create'
    get '/movies/:id', to: 'movies#show'
    delete '/movies/:id', to: 'movies#destroy'
  end
end

