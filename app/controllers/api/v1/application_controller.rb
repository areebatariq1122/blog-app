class Api::V1::ApplicationController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    protect_from_forgery unless: -> { request.format.json? }
    before_action :authenticate_user!
  
    protected
  
    def error_response(errors)
      render json: {
        errors: errors
      }, status: :unprocessable_entity
    end
end