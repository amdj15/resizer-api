Rails.application.routes.draw do
  api_version(:module => "V1", :path => {:value => "v1"}) do
    resources :gadgets, only: [:new]

    resources :images, only: [:index, :create] do
      post "resize", on: :member
    end
  end
end
