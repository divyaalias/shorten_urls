Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :links do
  	post :create_url, :on => :collection
  	get :fetch_original_url, :on => :member
  	get :stats, :on => :collection
  end

  resources :stats
  #set root url
  root 'links#create_url'

end
