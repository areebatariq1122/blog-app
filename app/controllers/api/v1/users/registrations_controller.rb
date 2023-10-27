module Api
    module V1
        module Users
            class RegistrationsController < DeviseTokenAuth::RegistrationsController
              protect_from_forgery unless: -> { request.format.json? }
        
              def create
                super 
              end
        
              def destroy
                super
              end
            end
        end
    end
  end