class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:login, :authenticate, :new , :create, :facebook]
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.build_image
  end
  def create
    @user = User.new(user_params)
    if @user.save(validate: false)
      SendEmailMailer.welcome(@user).deliver_now!
      flash[:notice] = "Successfully saved the record!"
      redirect_to users_path
    else
      flash[:notice] = "Opps, something went wrong"
      render :new
    end
  end
  def edit
    @user = User.find params[:id]
  end
  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      flash[:notice] = "Successfully updated the record!"
      redirect_to users_path
    else
      flash[:notice] = "Opps, something went wrong"
      render :edit
    end
  end
  def show
    @user = User.find params[:id]
  end
  def facebook
    user = User.omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to products_path
  end
  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:notice] = "Successfully deleted :)"
    redirect_to users_path
  end
  # def login
  #   @user = User.new
  # end
  def authenticate
    @user = User.db_authenticate(user_params)
    if @user
      # make session
      #session is a hash in rails, which allows to store user information at the server side
      #cookies is a hash, which allows to store user information at the client side
       session[:user_id] = @user.id
       flash[:notice] = "Logged in!"
       redirect_to users_path
    else
      # do not let him login
      flash[:notice] = "Username or Password do not match"
      render :login
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to root_path
  end
  private
  def user_params
    params.require(:user).permit!
  end
end


# params is strong parameter in rails which store user inputs in key and value pair
