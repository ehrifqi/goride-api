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
    full_name = params[:full_name]
    birthdate = params[:birthdate]
    license_plate = params[:license_plate]
    phone_number = params[:phone_number]
    license_number = params[:license_number]
    ktp_number = params[:ktp_number]
    address = params[:address]

    driver = Driver.where("id = ?", id).first
    if driver
      driver.email = email
      driver.full_name = full_name
      driver.birthdate = birthdate
      driver.license_plate = license_plate
      driver.phone_number = phone_number
      driver.license_number = license_number
      driver.ktp_number = ktp_number
      driver.address = address
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
