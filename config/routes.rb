Rails.application.routes.draw do
  devise_for :users
  get "favicon.ico" => redirect("/icon.svg")
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "habits#index"
  resources :habits do
    resources :completions, only: [ :create, :destroy ]
  end
end
