class UsersController < ApplicationController
  
  get "/signup" do
		erb :"users/create_user"
	end
	
	get "/login" do
		erb :"users/login"
	end

	post "/users" do
	  if params[:username] != "" && params[:email] != "" &&   params[:password] != ""
		   @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/show/#{@user.id}"
    else
      redirect "/signup"
	  end
  end
  
	post "/login" do
		@user = User.find_by(username: params[:username])
		
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/show/#{@user.id}"
    else
      redirect "/"
    end
  end
  
  get "/show/:id" do
		if logged_in?
		  @user = User.find_by(params[:id])
			erb :"users/show"
		else
			redirect "/login"
		end
	end

	get "/logout" do
		session.clear
		redirect "/"
	end
  
end