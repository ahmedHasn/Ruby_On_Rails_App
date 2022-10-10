Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :applications, only: [:index, :create] do
        get ':application_token' => :show, on: :collection
        put '' => :edit, on: :member
      end
      resources :chats, only: [:index, :create, :show, :edit] do
        collection do
          get 'applications/:application_token' => 'chats#application_chats'
        end
      end
      resources :messages, only: [:index, :create, :show, :edit] do
        collection do
          get 'search' => 'messages#search'
        end
      end
    end
  end
end
