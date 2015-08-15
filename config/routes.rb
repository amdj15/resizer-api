Rails.application.routes.draw do
  scope path: '/api' do
    api_version(:module => "Api::V1", :path => {:value => "v1"}) do
      resources :gadgets, only: [:new]

      resources :images, only: [:index, :create] do
        post "resize", on: :member
      end
    end
  end
end
