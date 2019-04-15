require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  get "/" do
    if logged_in?
      redirect "/show/#{current_user.id}"
    else 
      erb :index
    end
  end
  
  helpers do
    
		def logged_in?
			!!current_user
		end

		def current_user
			@current_user ||= User.find(session[:user_id])
		end
		
	end 

end
