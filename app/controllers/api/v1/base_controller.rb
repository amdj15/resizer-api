class Api::V1::BaseController < ApplicationController
  before_filter :check_access_token!

  protect_from_forgery with: :null_session
  respond_to :json

  rescue_from Exception do |e|
    api_error status: 500, errors: e
  end

  def check_access_token!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    unless @gadget = Gadget.find_by_token(token)
      api_error status: 401, errors: ApiError.new(t("errors.unauthenticated"))
    end
  end

  def api_error(status: 500, errors: [])
    if !Rails.env.production? && errors.respond_to?(:backtrace) && !errors.backtrace.nil?
      puts errors.inspect
      puts errors.backtrace.select { |x| x.match(Regexp.new(Rails.root.to_s)) }
    end

    errors = ApiError.new(t("errors.unexpected")) unless errors.class == ApiError
    render json: errors.to_json, status: status
  end
end