class Api::V1::Auth::DriversAuthController < ApplicationController
	def login
		email = params[:email]
    	password = params[:password]

    	driver = Driver.where(email: params[:email]).first
    	if driver&.valid_password?(password)
    		render json: {
    			token: generate_token({id: driver.id, role: Rails.application.secrets.role_driver}),
    			driver: driver.as_json(only: [:email, :driver_id])
    		},status: :created
    	else
    		# head(:unauthorized)
      		render err("Invalid Credentials", :unauthorized)
    	end
	end

    def register
        email = params[:email]
        password = params[:password]
        full_name = params[:full_name]
        birthdate = params[:birthdate]
        license_plate = params[:license_plate]
        rating = 0
        phone_number = params[:phone_number]
        license_number = params[:license_number]
        ktp_number = params[:ktp_number]
        address = params[:address]
        income = 0

        driver = Driver.new(email: email, password: password, full_name: full_name,
            birthdate: birthdate,license_plate: license_plate, rating: rating,
            phone_number: phone_number, license_number: license_number, ktp_number: ktp_number,
            address: address, income: income)
        if driver.valid?
            driver.save
            render json: {
                token: generate_token({id: driver.id, role: Rails.application.secrets.role_driver}),
                driver: driver.as_json(only: [:email, :driver_id])
            },status: :created
        else
            # head(:bad_request)
            render err("Register Failed", :bad_request)
        end
    end
end