Rails.application.routes.draw do
  resources :todos, only: %i(index create)
end
