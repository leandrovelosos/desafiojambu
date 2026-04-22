Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "users/new"
  get "users/create"
  root "search#index"

  get "search", to: "search#index"

  get "favorites", to: "favorites#index"
  post "favorites", to: "favorites#create"

  # 🔐 autenticação
  get "signup", to: "users#new"        # tela de cadastro
  post "signup", to: "users#create"    # criação de usuário

  get "login", to: "sessions#new"      # tela de login
  post "login", to: "sessions#create"  # criar sessão
  delete "logout", to: "sessions#destroy" # logout
 
  resources :favorites, only: [:index, :create, :destroy]
  # adiciona rota DELETE /favorites/:id

  get "details", to: "search#show"
  # rota para exibir detalhes de um item

  get "suggestions", to: "search#suggestions"
  # rota para sugestões de busca tipo do youtube
end