Rails.application.routes.draw do
  resources :ideas
  root 'welcome#index'
  get 'welcome/index'
end
