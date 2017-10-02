class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new {|c| request.format.json? }

  before_action :authenticate_user, unless: Proc.new {|c| request.format.json? }

  def authenticate_user
    if session[:user_id].blank?
        redirect_to root_path
    end
  end
  def get_current_user
   return User.find(session[:user_id])
  end
  helper_method :current_user
  def current_user
    true if not session[:user_id].blank?
  end
end
