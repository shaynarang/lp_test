LpTest::Application.routes.draw do
  resources :uploads do
    get "download", on: :member
  end
  root 'uploads#new'
end
