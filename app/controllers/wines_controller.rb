class WinesController < ApplicationController
  
    get "/wines" do 
        @wines = Wine.all 
        erb :"wines/wines"
      end 
  
end