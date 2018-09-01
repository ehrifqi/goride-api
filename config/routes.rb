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
        get 'get_place_suggestions', to: 'map#get_place_suggestions'
      end

      scope 'active_books', as: 'active_books' do
        post 'create_active_book', to: 'active_books#create_active_book'
        get 'get_by_member', to: 'active_books#get_by_member'
        get 'get_by_driver', to: 'active_books#get_by_driver'
      end
    end
  end
end
