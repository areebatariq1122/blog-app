class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
    include Pundit::Authorization
    protect_from_forgery
end



