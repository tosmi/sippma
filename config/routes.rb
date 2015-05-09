Rails.application.routes.draw do
  root               'sessions#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :patients, shallow: true do
    resources :consultations
    resources :invoices
    resources :relationships, only: [:create, :destroy]
  end

  get 'parent/search' => 'patients#parent_search'

  resources :abbrevations

  # we never create or delete a  setting.
  # there is just one
  resource  :settings, exept: [:new, :delete ]
end
