LpTest::Application.routes.draw do
  root 'uploads#index'
  resources :uploads do
    collection { post :import }
  end
end
