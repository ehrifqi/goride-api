class Api::V1::Auth::MembersAuthController < ApplicationController
  def login
    email = params[:email]
    username = params[:username]
    password = params[:password]

    member = Member.where(email: params[:email]).first
    if member&.valid_password?(password)
      render json: {
        token: generate_token({id: member.id, role: Rails.application.secrets.role_member}),
        member: member.as_json(only: [:email, :member_id])
      }, status: :created
    else
      # head(:unauthorized)
      render err("Invalid Credentials", :unauthorized)
    end
  end
end
