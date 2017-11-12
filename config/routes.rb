Rails.application.routes.draw do
  resources :todos, only: %i(index create) do
    member do
      patch :check
      patch :uncheck
    end
  end
end
