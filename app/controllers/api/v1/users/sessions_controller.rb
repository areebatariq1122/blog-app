module Api
    module V1
        module Users
            class Api::V1::Users::SessionsController < DeviseTokenAuth::SessionsController
              before_action :configure_permitted_parameters, if: :devise_controller?
              protect_from_forgery unless: -> { request.format.json? }

              def create
                super do |resource|
                  sign_in(:user, resource)          
                  render json: {                                                              
                    access_token: @token.token, 
                    client: @token.client,
                    uid: resource.uid,
                    user_id: resource.id
                  } and return
                end
              end

              protected

                def configure_permitted_parameters
                    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation])
                end
            end 
        end
    end
end  



