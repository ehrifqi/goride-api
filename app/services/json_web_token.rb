module JsonWebToken extend self
  SECRET = Rails.application.secrets.secret_key_base
  EXP = 3600
  ALGORITHM = 'HS256'

  def generate_token(payload)
    payload[:exp] = get_exp_time
    token = JWT.encode payload, SECRET, ALGORITHM
    token_json_format(token, get_exp_time)
  end

  def regenerate_token
    begin
      decoded_token = decode_token(bearer_token)

      if decoded_token
        payload = decoded_token[0]
        payload[:exp] = get_exp_time
        token = JWT.encode payload, SECRET, ALGORITHM
        token_json_format(token, get_exp_time)
      else
        nil
      end
    rescue JWT::ExpiredSignature
      render err("Credentials expired", :unauthorized)
    rescue JWT::VerificationError
      render err("Invalid Credentials", :unauthorized)
    end
  end

  def has_token_expire?(token)
    has_expired = false
    begin
      decoded_token = decode_token(token)
      if decoded_token == nil
        has_expired = true
      end
      has_expired
    rescue JWT::ExpiredSignature
      render err("Credentials expired", :unauthorized)
    rescue JWT::VerificationError
      render err("Invalid Credentials", :unauthorized)
    end
  end

  def extract_payload(token)
    begin
      JWT.decode token, SECRET, true, { algorithm: ALGORITHM }
    rescue JWT::ExpiredSignature
      render err("Credentials expired", :unauthorized)
    rescue JWT::VerificationError
      render err("Invalid Credentials", :unauthorized)
    end
  end

  def get_exp_time
    Time.now.to_i + EXP
  end

  def verify_role(roles)
    begin
      decoded_token = decode_token(bearer_token)
      if decoded_token
        payload = decoded_token[0]
        if roles.include?(payload["role"]) == false
          render err "Invalid credentials", :unauthorized
        end
      else
        render err "Invalid credentials", :unauthorized
      end
    rescue JWT::ExpiredSignature
      render err("Crendentials expired", :unauthorized)
    rescue JWT::VerificationError
      render err("Invalid Credentials", :unauthorized)
    rescue JWT::DecodeError
      render err("Invalid Credentials", :unauthorized)
    end
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    header.gsub(pattern, '') if header && header.match(pattern)
  end

  def decode_token(token)
    decoded_token = []
    decoded_token = JWT.decode token, SECRET, true, { algorithm: ALGORITHM }
    decoded_token
  end

  def token_json_format(token, exp_at)
    {access_token: token, expires_at: exp_at, token_type: "Bearer"}
  end
end