module SessionsHelper
    def sign_in(user)
        session[:user_id] = user.id
        return true
    end

    def current_user
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            if user.present?
                return user
            else
                return nil
            end
        else
            return nil
        end
    end

    def signed_in?
        if current_user.present?
            true
        else
            false
        end
    end

    def sign_out
        session[:user_id] = nil
        return true
    end

end
