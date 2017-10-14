class StaticController < ApplicationController
    def index
        @default = ScenariosExtension::Default
        render 'home'
    end
end
