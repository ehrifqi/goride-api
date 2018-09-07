class Api::V1::DriverDetailsController < ApplicationController
  before_action except: [

  ] do
    verify_role([Rails.application.secrets.role_member, Rails.application.secrets.role_driver])
  end

  def show
  	id = params[:id]
  	driver_detail = DriverDetail.where("id = ?", id).first
  	if driver_detail
  	  render json: {
        driver_detail: driver_detail,
        token: regenerate_token
      }, status: :ok
  	else
  	  render err("Invalid ID", :bad_request)
  	end
  end
end
