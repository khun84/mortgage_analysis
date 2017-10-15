class StaticController < ApplicationController
    def index
        # initiate the default inputs variable
        @default = ScenariosExtension::Default
        render 'home'
    end
end
