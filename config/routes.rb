Rails.application.routes.draw do
	get 'pages/landing'

	resources :flights
	devise_for :users
	root 'pages#landing'
	post 'search' => 'flights#search', :default => {:fotmat => 'js'}
	post 'upgrade' => 'users#upgrade'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
