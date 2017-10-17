class StaticController < ApplicationController
    def index
        # initiate the default inputs variable
        default_input = ScenariosExtension::DefaultInput.new
        render 'home', locals: {input: default_input}
    end
end
