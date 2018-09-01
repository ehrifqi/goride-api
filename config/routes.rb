Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        scope 'members_auth', as: 'members' do
          post 'login', to: 'members_auth#login'
          post 'register', to: 'members_auth#register'
        end

        scope 'drivers_auth', as: 'drivers' do
          post 'login', to: 'drivers_auth#login'
          post 'register', to: 'drivers_auth#register'
        end
      end

      scope 'map', as: 'map' do
        get 'get_price', to: 'map#get_price'
      end
    end
  end
end
