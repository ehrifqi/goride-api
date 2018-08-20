module RequestHelpers
  def merge_header(header)
    request.headers.merge!(header)
  end

  module JsonHelpers
    def response_json
      JSON.parse(response.body)
    end
  end

  module AuthHelpers
    require_relative '../../app/services/json_web_token.rb'
    def auth_headers(id, role)
      token = JsonWebToken.generate_token({id: id, role: role})[:access_token]
      {
        'Authorization': "Bearer #{token}"
      }
    end
  end
end