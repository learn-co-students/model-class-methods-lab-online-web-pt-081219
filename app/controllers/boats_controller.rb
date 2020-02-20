class BoatsController < ApplicationController
    def index 
        @boats = Boat.all
        @last = Boat.non_sailboats
        @nocapt = Boat.without_a_captain
    end
end