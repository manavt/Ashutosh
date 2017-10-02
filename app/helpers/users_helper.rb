module UsersHelper
  def signed_in_as
     if current_user
         user = User.find session[:user_id]
         user.email
     end
  end
end
