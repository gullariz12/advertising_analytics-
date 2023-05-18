Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/import/campagin', to: 'home#import_campagin'

  root "home#dashboard"
end
