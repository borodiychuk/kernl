class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  # See https://coderwall.com/p/8z7z3a/rails-4-solution-for-can-t-verify-csrf-token-authenticity-json-requests
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

  prepend_before_action :assign_account

  # Rescue from any exception by logging to rollbar and rethrow it
  rescue_from Exception do |exception|
    Rollbar.error exception
    raise exception
  end if

  protected

  def authenticate!
    raise AuthorizationException unless @user
  end

  def assign_account
    @user    = current_user if user_signed_in?
    @account = user_signed_in? ? current_user.account : Account.find_by_id(params[:account_id])
  end

  # This method is called in case we just need to respond smth as OK
  def answer_ok
    head :no_content
  end

end
