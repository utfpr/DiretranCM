Rails.application.routes.draw do
  resources :documentos
  resources :categoria
  resources :bairros
  resources :estados
  resources :funcionarios
  resources :datalogs
  resources :cids
  resources :cidades

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
