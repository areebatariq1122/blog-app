class ApplicationController < ActionController::Base
<<<<<<< HEAD
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit::Authorization
  protect_from_forgery
=======
    include Pundit::Authorization
>>>>>>> 116c7bb (Seed File and Serializer added)
end
