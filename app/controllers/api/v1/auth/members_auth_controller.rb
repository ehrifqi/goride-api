class Api::V1::Auth::MembersAuthController < ApplicationController
  def login
    email = params[:email]
    # username harusnya dihapus karena udah dihapus dari table
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

  def register
        email = params[:email]
        password = params[:password]
        full_name = params[:full_name]
        phone_number = params[:phone_number]
        go_pay_value = 0
        go_point_value = 0
    
        member = Member.new(email: email, password: password, full_name: full_name,
            phone_number: phone_number, go_pay_value: go_pay_value, go_point_value: go_point_value)
        if member.valid?
            member.save
            render json: {
                token: generate_token({id: member.id, role: Rails.application.secrets.role_member}),
                member: member.as_json(only: [:email, :driver_id])
            },status: :created
        else
            # head(:bad_request)
            render err("Register Failed", :bad_request)
        end
  end
end
