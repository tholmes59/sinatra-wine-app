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
            @wine = Wine.create(wine_name: params[:wine_name], type: params[:type], varietal: params[:varietal], region: params[:region], year: params[:year], price: params[:price], tasting_notes: params[:tasting_notes], user_id: current_user.id)
            redirect to "/wines/#{@wine.id}"
        else
            redirect "/wines/new"
        end
    end

    get '/wines/:id' do
        @wine = Wine.find_by_id(params[:id])
        erb :"/wines/show_wine"
      end
      
      get "/wines/:id/edit" do  
        @wine = Wine.find_by_id(params[:id])
        if logged_in?
          if authorized_to_edit?(@wine)
          erb :"wines/edit_wine"
          else
            redirect "users/show/#{current_user.id}"
          end
        else
          redirect "/users/login"
        end
      end
       
      patch "/wines/:id" do 
        @wine = Wine.find_by_id(params[:id])
        if logged_in?
          if @wine.user == current_user && params[:wine_name] != ""
            @wine.wine_name = params[:wine_name]
            @wine.type = params[:type]
            @wine.varietal = params[:varietal]
            @wine.region = params[:region]
            @wine.year = params[:year]
            @wine.price = params[:price]
            @wine.tasting_notes = params[:tasting_notes]
            @wine.save
            redirect to "/wines/#{@wine.id}"
          else
            redirect "users/show/#{current_user.id}"
          end 
        else
          redirect "/users/login"
        end
      end

      delete "/wines/:id" do 
        @wine = Wine.find_by_id(params[:id])
        if authorized_to_edit?(@wine)
          @wine.destroy
          redirect to "/wines"
        else
          redirect to '/wines'
        end
      end

end

