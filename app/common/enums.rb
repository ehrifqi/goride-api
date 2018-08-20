module Enums
  module Roles
    ROLE_MEMBER = Rails.application.secrets.role_member
    ROLE_DRIVER = Rails.application.secrets.role_driver
  end
end