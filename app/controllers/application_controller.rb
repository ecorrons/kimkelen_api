class ApplicationController < ActionController::API

  include ActionController::ImplicitRender

  respond_to :json

  def invalid_request
    render json: { error: I18n.t("errors.messages.invalid_request"), status: 400 }, status: :bad_request
  end 
  
end
