class Api::V1::Auth::DriversAuthController < ApplicationController
	def login
		email = params[:email]
		# kalau driver kayaknya gausah username sih, cmn gw tulis dulu buat jaga"
    	username = params[:username]
    	password = params[:password]

    	driver = Driver.where(email: params[:email]).first
    	if driver&.valid_password?(password)
    		render json: {
    			token: generate_toker({id: driver.id, role: Rails.application.secrets.role_driver})
    			driver: driver.as_json(only: [:email, :driver_id])
    		},status: :created
    	else
    		# head(:unauthorized)
      		render err("Invalid Credentials", :unauthorized)
    	end
	end
end