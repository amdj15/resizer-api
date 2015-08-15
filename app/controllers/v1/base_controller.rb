class V1::BaseController < ApplicationController
  before_filter :check_access_token!

  protect_from_forgery with: :null_session
  respond_to :json

  def check_access_token!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    unless @gadget = Gadget.find_by_token(token)
      api_error(status: 401, errors: {error: "Unauthorized"})
    end
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: errors.to_json, status: status
  end
end



