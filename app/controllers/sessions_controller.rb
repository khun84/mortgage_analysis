class SessionsController < ApplicationController

    def create_from_omniauth
        auth_hash = request.env["omniauth.auth"]
        authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

        # if: previously already logged in with OAuth
        if authentication.user
            user = authentication.user
            authentication.update_token(auth_hash)
            redirect = signed_in_redirect_path
            flash[:notice] = 'Sign in successfully'

            # else: user logs in with OAuth for the first time
        else
            user = User.create_with_auth_and_hash(authentication, auth_hash)
            flash[:notice] = 'Sign up successfully!'
            redirect = signed_up_redirect_path

        end

        sign_in(user)
        redirect_to redirect

    end

    def destroy
        sign_out
        redirect_to signed_out_redirect_path
    end


    private

    def signed_in_redirect_path
        root_path
    end

    def signed_up_redirect_path
        root_path
    end

    def signed_out_redirect_path
        root_path
    end

end
