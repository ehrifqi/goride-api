class Api::V1::MembersController < ApplicationController
  before_action except: [

  ] do
    verify_role([Rails.application.secrets.role_member, Rails.application.secrets.role_driver])
  end

  def show
    id = params[:id]
    member = Member.where("id = ?", id).first
    if member
      render json: { 
        member: member,
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
    phone_number = params[:phone_number]
    go_point_value = params[:go_point_value]

    member = Member.where("id = ?", id).first
    if member
      member.update(email: email)
      member.update(password: password)
      member.update(full_name: full_name)
      member.update(phone_number: phone_number)
      member.update(go_point_value: go_point_value)
      member.save
      
      render json: { 
        member: member,
        token: regenerate_token
      }, status: :ok
    else
      render err("Invalid ID", :bad_request)
    end
  end
end
