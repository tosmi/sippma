Rails.application.routes.draw do
  root               'sessions#new'
  post   'login'  => 'session#create'
  delete 'logout' => 'sessions#destroy'
end
