Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  scope '/api' do
    get '/watchlists', to: 'watchlists#index'
    post '/watchlists', to: 'watchlists#create'
    get '/watchlists/:id', to: 'watchlists#show'
    delete '/watchlists/:id', to: 'watchlists#destroy'
    scope '/auth' do
      post '/sign_up', to: 'users#create'
      post '/sign_in', to: 'users#sign_in'
    end
  
  end
end

