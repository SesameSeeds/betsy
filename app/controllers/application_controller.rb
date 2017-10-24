class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user


  # returns current user if already exists in session
  # else creates a new user and returns it
  #TODO move to session if no other controller uses this method
  def get_current_user
    if @auth_user
      return User.find_by(id: session[:user_id])
    else
      return User.create
    end
  end

  # =========
  protected
  def render_404
    render file: "/public/404.html", status: 404
  end

  # =========
  private
  def find_user
    if session[:user_id]
      @auth_user = Merchant.find_by(user_id: session[:user_id])
    end
  end

  def authenticate_user
    if !@auth_user
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do this"
    end
  end
end
