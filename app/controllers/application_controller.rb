class ApplicationController < ActionController::API
  rescue_from StandardError, with: :genaral_error

  def genaral_error(e)
    render json: {errors: e.message}, status: 404
  end
end
