Rails.application.routes.draw do
  root               'sessions#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :patients, shallow: true do
    resources :consultations
  end

end
