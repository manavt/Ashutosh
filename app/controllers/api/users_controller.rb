class Api::UsersController < ApplicationController
  # skip_before_action :authenticate_user, only: :index  # not valid line go wit oauth2 or devise with auth token or simple httpuser and password
  #http_basic_authenticate_with name: "admin", password: "secret"
  def index
    @user = User.all
    respond_to do | format |
      format.json {render json: @user}
      format.html {}
    end
  end
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
         format.json {render json:   @user, status: 200, message: "Record saved!" }
       else
         format.json {render json:  @user.errors }
      end
    end
  end
  def update
    @user = User.find params[:id]
    respond_to do |format|
      if @user.update(user_params)
         format.json {render json:   @user, status: 200, message: "Record saved!" }
       else
         format.json {render json:  @user.errors }
      end
    end
  end
  def destroy
    @user = User.find params[:id]
    respond_to do |format|
         @user.delete
         format.json {render json:   {message: "Deleted"} }
      end
  end
  private
  def user_params
    params.require(:user).permit!
  end
end
