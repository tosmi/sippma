Rails.application.routes.draw do
  root               'sessions#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :patients, shallow: true do
    resources :consultations
    resources :invoices
  end

  resources :abbrevations

  # we never create a new setting, or delete the a setting
  # there is just one
  resource  :settings, exept: [:new, :delete ]
end
