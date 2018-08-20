module ErrorHandler
  def err(message, status_code)
    {json: {
      message: message
    }, status: status_code}
  end
end