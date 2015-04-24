Rails.application.routes.draw do
  root               'sessions#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :patients, shallow: true do
    resources :consultations
    resources :invoices
  end

  get 'add_parent' => 'patients#add_parent'

  resources :abbrevations

  # we never create or delete a  setting.
  # there is just one
  resource  :settings, exept: [:new, :delete ]
end
