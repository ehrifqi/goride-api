require_relative "../services/json_web_token.rb"
require_relative "../handlers/error_handler.rb"

class ApplicationController < ActionController::API
  #handlers
  include ErrorHandler

  #services
  include JsonWebToken
end
