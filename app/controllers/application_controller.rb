require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  get "/" do
    if !logged_in?
      erb :index
    else 
      redirect "/show/#{current_user.id}"
    end
  end
  
  helpers do
    
    def logged_in?
      !!current_user
    end
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
    def authorized_to_edit?(wine)
      wine.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login"
      end
    end
  
  end

end
