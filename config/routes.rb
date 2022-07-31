Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: 'posts#index', as: :root
  get('/change_password',{to: "users#change_password" , as: :change_password})
  patch('/change_password',{to: 'users#change_password', as: :update_password})

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only:[:new, :create, :edit, :update]
  resource :session, only:[:new, :create, :destroy]

end
