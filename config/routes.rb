Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    get 'card_sets/:code', to: 'card_sets#show'
    resources :card_sets, only: [:index]
end
