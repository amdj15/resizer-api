class ApiError < StandardError
  attr_reader :error

  def initialize(message)
    @error = message.capitalize
  end
end