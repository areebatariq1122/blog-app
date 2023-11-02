class RegistrationsPresenter 
    def initialize(user)
        @user = user
    end

    def email
        @user.email
    end
    
    def name
        @user.email.match(/([^@]*)/).to_s
    end

  end 
