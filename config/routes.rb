Rails.application.routes.draw do

  root 'home#index'
  match 'past'  => 'past#index', via: :get, as: :past
  match 'future'  => 'future#index', via: :get, as: :future

end
