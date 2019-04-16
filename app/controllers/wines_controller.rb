class WinesController < ApplicationController
  
    get "/wines" do 
        @wines = Wine.all 
        erb :"wines/wines"
      end 

    get "/wines/new" do
      erb :"wines/new"
    end
    
    post "/wines" do
        if !logged_in?
            redirect "/users/login"
        end
        if params[:wine_name] != ""
            @wine = Wine.create(wine_name: params[:wine_name], type: params[:type], varietal: params[:varietal], region params[:region], 
            year: params[:year], price: params[:price], tasting_notes: params[:tasting_notes], user_id: current_user.id)
            redirect to "/wines/#{@wine.id}"
        else
            redirect "/wines/new"
        end
    end
  
end

