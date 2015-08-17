class ApiError < StandardError
  attr_reader :error

  def initialize(message)
    @errors = if message.class == String
      [message.capitalize]
    else
      message
    end
  end
end