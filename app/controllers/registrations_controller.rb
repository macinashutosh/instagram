class RegistrationsController < Devise::RegistrationsController


  private

  def sign_up_params
    params.require(:user).permit(:fullname, :username, :email, :password, :password_confirmation,:avatar)
  end

  def account_update_params
    params.require(:user).permit(:fullname, :username,:avatar ,:email, :password, :password_confirmation, :current_password)
  end

protected
  def update_resource(resource, params)
    if user.id == current_user.id
    resource.update_without_password(params)
    else
    end
  end
end
