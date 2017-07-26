class RegistrationsController < Devise::RegistrationsController


  private

  def sign_up_params
    params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation,:avatar)
  end

  def account_update_params
    params.require(:user).permit(:fullname, :username,:avatar ,:email, :password, :password_confirmation, :current_password)
  end
end
