class V1::BaseController < ApplicationController
  before_filter :check_access_token!

  protect_from_forgery with: :null_session
  respond_to :json

  rescue_from Exception do |e|
    api_error status: 500, errors: e
  end

  def check_access_token!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    unless @gadget = Gadget.find_by_token(token)
      api_error(status: 401, errors: {error: "Unauthorized"})
    end
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.inspect
      puts errors.backtrace.select { |x| x.match(Regexp.new(Rails.root.to_s)) } if errors.respond_to? :backtrace
    end

    errors = { error: "Unexpected error" } unless errors.respond_to?(:any?) && errors.any?
    render json: errors.to_json, status: status
  end
end



