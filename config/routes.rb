Traveljournal::Application.routes.draw do
  resources :hotels
  root :to => "hotels#index"
end

