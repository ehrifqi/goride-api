class Api::V1::DriversController < ApplicationController
  before_action except: [

  ] do
    verify_role([Rails.application.secrets.role_member, Rails.application.secrets.role_driver])
  end

  def show
  	id = params[:id]
  	driver = Driver.where("id = ?", id).first
  	if driver
  	  render json: {
        driver: driver,
        token: regenerate_token
      }, status: :ok
  	else 
  	  render err("Invalid ID", :bad_request)
  	end
  end

  def update
    id = params[:id]
    email = params[:email]
    password = params[:password]
    full_name = params[:full_name]
    birthdate = params[:birthdate]
    license_plate = params[:license_plate]
    rating = params[:rating]
    phone_number = params[:phone_number]
    license_number = params[:license_number]
    ktp_number = params[:ktp_number]
    address = params[:address]
    income = params[:income]

    driver = Driver.where("id = ?", id).first
    if driver
      driver.update(email: email)
      driver.update(password: password)
      driver.update(full_name: full_name)
      driver.update(birthdate: birthdate)
      driver.update(license_plate: license_plate)
      driver.update(rating: rating)
      driver.update(phone_number: phone_number)
      driver.update(license_number: license_number)
      driver.update(ktp_number: ktp_number)
      driver.update(address: address)
      driver.update(income: income)
      driver.save

      render json: {
        driver: driver,
        token: regenerate_token
      }, status: :ok
    else
      render err("Invalid ID", :bad_request)
    end
  end
end
