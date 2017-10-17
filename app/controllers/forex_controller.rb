class ForexController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :get_forex

    before_action do
        if !signed_in?
            flash[:error] = 'Please sign in to perform this action.'
            redirect_back fallback_location: root_path
        end
    end

    def index
        @rates = {}
        render 'index'
    end

    def get_forex
        forex = Forex.new
        if !forex.status
            flash[:error] = forex.error
            @rates = {}
        else
            @rates = forex.get_rates!
        end
        
        respond_to do |format|
            format.html {render 'index'}
            format.js {render 'index'}
        end
    end


end
