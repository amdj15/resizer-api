Rails.application.routes.draw do
  scope path: '/api' do
    api_version(:module => "Api::V1", :path => {:value => "v1"}) do
      resources :gadgets, only: [:new]

      resources :images, only: [:index, :create] do
        post "resize", on: :member
      end

      get '*unmatched_route', to: 'base#not_found'
    end
  end
end
