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
end
