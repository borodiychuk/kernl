class Api::V1::Private::ProfilesController < Api::V1::PrivateController

  def show
    render json: @user.to_json(
      methods: [:password_confirmation_needed]
    )
  end

  def update
    if profile_params[:password].blank? || !@user.password_confirmation_needed
      @user.update_attributes! profile_params
    else
      raise GenericException, "Passwortbestätigung falsch!" unless @user.update_with_password profile_params
    end
    headers["X-Message"] = "Password has been changed" unless profile_params[:password].blank?
    show
  end

private

  def profile_params
    params.require(:profile).permit(:name, :password, :current_password)
  end

end
