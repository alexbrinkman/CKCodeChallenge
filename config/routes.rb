Rails.application.routes.draw do
  root 'home#index'
  match 'past(/:show)'  => 'past#index', via: :get, as: :past
  match 'future(/:show)'  => 'future#index', via: :get, as: :future
end
