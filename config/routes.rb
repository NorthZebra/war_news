Rails.application.routes.draw do
  
  resources :comments
  devise_for :users
  resources :news do
    member do 
      put "like",    to: "news#upvote" 
      put "dislike", to: "news#downvote" 
    end
    resources :comments
  end
  root to: 'page#index'

end
