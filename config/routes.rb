Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        scope 'members_auth', as: 'members' do
          post 'login', to: 'members_auth#login'
        end
        scope 'drivers_auth', as: 'drivers' do
          post 'login', to: 'drivers_auth#login'
        end
      end
    end
  end
end
